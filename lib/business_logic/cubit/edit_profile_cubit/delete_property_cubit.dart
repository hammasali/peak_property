import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'delete_property_state.dart';

class DeletePropertyCubit extends Cubit<DeletePropertyState> {
  DeletePropertyCubit() : super(DeletePropertyInitial());

  void propertyDelete(UploadModel model) async {
    try {
      emit(DeletePropertyLoading());
      await FirebaseRepo.instance.propertyDelete(model);
      emit(DeletePropertySuccess());
    } on PlatformException catch (e) {
      emit(DeletePropertyUnSuccess(e.message.toString()));
    } on FirebaseException catch (e) {
      emit(DeletePropertyUnSuccess(e.message.toString()));
    } catch (e) {
      emit(DeletePropertyUnSuccess(e.toString()));
    }
  }
}
