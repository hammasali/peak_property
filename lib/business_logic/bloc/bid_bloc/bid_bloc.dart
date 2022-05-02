import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/bider_model.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'bid_event.dart';

part 'bid_state.dart';

class BidBloc extends Bloc<BidEvent, BidState> {
  List<String> url = [];
  List<UploadModel> bids = [];

  BidBloc() : super(BidInitial()) {
    on<FetchBids>((event, emit) async {
      try {
        emit(BidLoading());
        bids.clear();
        final QuerySnapshot properties =
            await FirebaseRepo.instance.getBidsProperty().get();

        for (var e in properties.docs) {
          if (e.exists) {
            final String url = await FirebaseRepo.instance
                .downloadAllUserURLs(e.get('uid'), e.get('pickedFilesName')[0]);
            bids.add(UploadModel.fromMap(
                e.data() as Map<String, dynamic>, url, e.id));
          } else {
            throw 'no data available';
          }
        }
        emit(BidSuccess(model: bids, url: url));
      } on FirebaseException catch (e) {
        emit(BidUnSuccess('Unexpected Error ${e.code}'));
      } catch (e) {
        emit(BidUnSuccess('Unexpected Error'));
      }
    });

    on<GetBidUrls>((event, emit) async {
      try {
        emit(BidLoading());
        url.clear();
        for (var e in event.model.pickedFilesName as List) {
          url.add(await FirebaseRepo.instance
              .downloadAllUserURLs(event.model.uid.toString(), e));
        }
        emit(BidSuccess(model: bids, url: url));
      } on PlatformException catch (e) {
        emit(BidUnSuccess('Unexpected Error ${e.code}'));
      } on FirebaseException catch (e) {
        emit(BidUnSuccess('Unexpected Error ${e.code}'));
      } catch (e) {
        emit(BidUnSuccess('Unexpected Error'));
      }
    });

    on<PlaceBid>((event, emit) async {
      try {
        emit(BidLoading());

        String _createdAt =
            DateFormat('EEE, MMM d, ' 'yyyy h:mm a').format(DateTime.now());

        BidersModel model = BidersModel(
            image: event.image, price: event.price, createdAt: _createdAt);

        await FirebaseRepo.instance.biders(event.docId, model);

        emit(BidSuccess(model: bids, url: url, bidModel: model));
      } on PlatformException catch (e) {
        emit(BidUnSuccess('Unexpected Error ${e.code}'));
      } on FirebaseException catch (e) {
        emit(BidUnSuccess('Unexpected Error ${e.code}'));
      } catch (e) {
        emit(BidUnSuccess('Unexpected Error'));
      }
    });
  }
}
