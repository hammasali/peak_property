import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/models/user_info_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'fixed_detail_state.dart';

class FixedDetailCubit extends Cubit<FixedDetailState> {
  FixedDetailCubit() : super(FixedDetailInitial());

  void getUrls(UploadModel model) async {
    try {
      emit(FixedDetailLoading());
      List<String> url = [];

      for (var e in model.pickedFilesName as List) {
        url.add(await FirebaseRepo.instance
            .downloadAllUserURLs(model.uid.toString(), e));
      }

      emit(FixedDetailSuccess(url));
    } on PlatformException catch (e) {
      emit(FixedDetailUnSuccess(e.code.toString()));
    } on FirebaseException catch (e) {
      emit(FixedDetailUnSuccess(e.code.toString()));
    } catch (e) {
      emit(FixedDetailUnSuccess('Something Went Wrong.'));
    }
  }


}
