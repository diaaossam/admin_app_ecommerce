import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app_ecommerce/main_layout/main_layout.dart';
import 'package:admin_app_ecommerce/screens/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:admin_app_ecommerce/screens/on_boarding/cubit/on_boarding_states.dart';
import 'package:admin_app_ecommerce/shared/styles/colors.dart';
import '../../shared/helper/constants.dart';
import '../../shared/helper/methods.dart';
import '../../shared/services/local/cache_helper.dart';
import '../login_register/complete_profile/complete_profile_screen.dart';
import '../login_register/sign_in/sign_in_screen.dart';
import 'components/body.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
          listener: (context, state) {
            if (state is GoToSignIn) {
              navigateToAndFinish(context, SignInScreen());
            } else if (state is GoToHome) {
              navigateToAndFinish(context, MainLayout());
            } else if (state is GoToCompleteProfile) {
              navigateToAndFinish(context, CompleteProfileScreen());
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Body(),
              appBar: AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      //OnBoardingCubit.get(context).checkNavigation();

                      submit(context);
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: kPrimaryColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
  static void submit(BuildContext context) {
    CachedHelper.saveData(key: ON_BOARDING, value: true).then((value) {
      if (value) {
        navigateToAndFinish(context, SignInScreen());
      }
    });
  }
}
