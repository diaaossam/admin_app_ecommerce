part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashMainLayout extends SplashState {}
class SplashOnBoarding extends SplashState {}
class SplashCompleteProfile extends SplashState {}
class SplashSignIn extends SplashState {}
