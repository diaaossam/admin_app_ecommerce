import 'package:admin_app_ecommerce/screens/login_register/sign_in/cubit/sign_in_cubit.dart';
import 'package:admin_app_ecommerce/screens/login_register/sign_in/cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app_ecommerce/shared/components/social_card.dart';
import 'package:admin_app_ecommerce/shared/helper/methods.dart';
import '../../../../main_layout/main_layout.dart';
import '../../../../shared/components/no_account_text.dart';
import '../../../../shared/helper/size_config.dart';
import '../../../../shared/widgets/custom_widgets.dart';

import '../../complete_profile/complete_profile_screen.dart';
import '../../phone_screen/phone_screen.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {

        if(state is SignInLoadingState){
          showCustomProgressIndicator(context);
        }
        else if(state is SignInFailuerState){
          Navigator.pop(context);
          String errorMsg = state.error;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 5),
          ));
        }
        else if(state is SignInSuccessStateCompletetProfile){
          Navigator.pop(context);
          navigateToAndFinish(context,CompleteProfileScreen());
        }
        else if(state is SignInSuccessStateMainLayout){
          Navigator.pop(context);
          navigateToAndFinish(context,MainLayout());
        }
      },
      builder: (context, state) {
        return Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.bodyHeight * 0.04),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.bodyHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.bodyHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {
                        SignInCubit.get(context).signInWithGoogle();
                      },
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {
                        SignInCubit.get(context).signInWithFacebook();

                      },
                    ),
                    SocialCard(
                      icon: "assets/icons/Phone.svg",
                      press: () {
                        navigateTo(context, PhoneVerifactionScreen());
                      },
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        );
      },
    );
  }
}
