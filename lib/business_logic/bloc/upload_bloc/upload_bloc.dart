import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'upload_event.dart';

part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadInitial()) {

    on<PriceRangeEvent>(
        (event, emit) => emit(PriceRangeState(event.start, event.end)));
    on<TimeFrameEvent>((event, emit) => emit(TimeframeState(event.val)));
    on<AreaRangeEvent>((event, emit) => emit(AreaRangeState(event.val)));
    on<AreaRangeUnitEvent>(
        (event, emit) => emit(AreaRangeUnitState(event.val)));
    on<BedroomEvent>((event, emit) => emit(BedroomState(event.val)));
    on<BathroomEvent>((event, emit) => emit(BathroomState(event.val)));

    on<UploadButtonEvent>((event, emit) async {
      try {
        emit(UploadLoading());
        String _createdAt =
            DateFormat('EEE, MMM d, ' 'yyyy h:mm a').format(DateTime.now());
        List<String> pickedFilesName = [];

        var images = event.pickedFile;
        if (images != null) {
          for (var element in images) {
            pickedFilesName.add(element.name);
          }
        }

        UploadModel uploadModel = UploadModel(
          pickedFile: images,
          pickedFilesName: pickedFilesName,
          bedrooms: event.bedrooms,
          bathrooms: event.bathrooms,
          address: event.address,
          areaRange: event.areaRange,
          category: event.category,
          areaType: event.areaType,
          city: event.city,
          description: event.description,
          endPrice: event.endPrice,
          startPrice: event.startPrice,
          state: event.state,
          timeRange: event.timeRange,
          title: event.title,
          type: event.type,
          createdAt: _createdAt,
          uid: FirebaseRepo.instance.getCurrentUser()!.uid,
          preference: event.preference == 0 ? 'Fixed Price' : 'Bid Price',
          bidTime: event.bidTime,
          endingTime: event.endingTime
        );

        await FirebaseRepo.instance.uploadPropertyData(uploadModel);
        emit(UploadSuccess(uploadModel));
      } on PlatformException catch (e) {
        emit(UploadUnSuccess(e.message.toString()));
      } on FirebaseException catch (e) {
        emit(UploadUnSuccess(e.message.toString()));
      } catch (e) {
        emit(UploadUnSuccess('Something Went Wrong.'));
      }
    });
  }
}
