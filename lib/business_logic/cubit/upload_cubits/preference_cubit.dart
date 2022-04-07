import 'package:bloc/bloc.dart';


class PreferenceCubit extends Cubit<int> {
  PreferenceCubit() : super(0);

  onPreferenceEvent(int val) => emit(val);

}
