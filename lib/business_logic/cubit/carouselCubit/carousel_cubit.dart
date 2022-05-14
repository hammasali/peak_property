import 'package:bloc/bloc.dart';


class CarouselCubit extends Cubit<int> {
  CarouselCubit() : super(0);

  currentSlide(int index) => emit(index);
}
