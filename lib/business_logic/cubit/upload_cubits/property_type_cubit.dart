import 'package:bloc/bloc.dart';


class PropertyTypeCubit extends Cubit<int> {
  PropertyTypeCubit() : super(0);

  onPropertyTypeEvent(int val) => emit(val);
}
