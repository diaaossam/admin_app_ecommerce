import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app_ecommerce/screens/on_boarding/cubit/on_boarding_states.dart';


class OnBoardingCubit extends Cubit<OnBoardingStates> {
  bool isLast = false;

  OnBoardingCubit() : super(InitialStates());

  static OnBoardingCubit get(BuildContext context) => BlocProvider.of(context);

  void changePageViewState(bool from) {
    isLast = from;
    emit(LastPageView());
  }

}
