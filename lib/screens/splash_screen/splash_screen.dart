import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app_ecommerce/main_layout/main_layout.dart';
import 'package:admin_app_ecommerce/screens/on_boarding/on_boarding_screen.dart';
import 'package:admin_app_ecommerce/screens/splash_screen/cubit/splash_cubit.dart';
import 'package:admin_app_ecommerce/shared/helper/methods.dart';
import 'package:admin_app_ecommerce/shared/helper/size_config.dart';
import 'package:admin_app_ecommerce/shared/styles/colors.dart';
import '../login_register/complete_profile/complete_profile_screen.dart';
import '../login_register/sign_in/sign_in_screen.dart';


class SplashScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => SplashCubit()..checkUserState(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashOnBoarding) {
            navigateToAndFinish(context, OnBoardingScreen());
          }
          else if (state is SplashMainLayout) {
            navigateToAndFinish(context, MainLayout());
          }
          else if (state is SplashCompleteProfile) {
            navigateToAndFinish(context, CompleteProfileScreen());
          }
          else if (state is SplashSignIn) {
            navigateToAndFinish(context, SignInScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(appBar: AppBar(), body: setLoadingPage());
        },
      ),
    );
  }

  Widget setLoadingPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash_1.png',
            height: getProportionateScreenHeight(265),
            width: getProportionateScreenWidth(235),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
