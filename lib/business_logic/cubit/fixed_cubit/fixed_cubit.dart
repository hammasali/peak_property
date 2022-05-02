import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

part 'fixed_state.dart';

class FixedCubit extends Cubit<FixedState> {
  FixedCubit() : super(FixedInitial());

  void fetchProperties() async {
    try {
      emit(FixedLoading());
      List<UploadModel> homes = [];
      List<UploadModel> plot = [];
      List<UploadModel> commercial = [];

      final QuerySnapshot properties =
          await FirebaseRepo.instance.getFixedHomes().get();

      for (var e in properties.docs) {
        final String url = await FirebaseRepo.instance
            .downloadAllUserURLs(e.get('uid'), e.get('pickedFilesName')[0]);

        if (e.get('category') == 'Homes') {
          homes.add(
              UploadModel.fromMap(e.data() as Map<String, dynamic>, url, e.id));
        } else if (e.get('category') == 'Plots') {
          plot.add(
              UploadModel.fromMap(e.data() as Map<String, dynamic>, url, e.id));
        } else {
          commercial.add(
              UploadModel.fromMap(e.data() as Map<String, dynamic>, url, e.id));
        }
      }
      emit(FixedSuccess(homes, plot, commercial));
    } on FirebaseException catch (e) {
      emit(FixedUnSuccess(msg: 'Unexpected Error ${e.code}'));
    } catch (e) {
      emit(FixedUnSuccess(msg: 'Unexpected Error'));
    }
  }
}
