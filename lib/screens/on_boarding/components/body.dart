import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:admin_app_ecommerce/main_layout/main_layout.dart';
import 'package:admin_app_ecommerce/screens/on_boarding/components/splash_content.dart';
import 'package:admin_app_ecommerce/screens/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:admin_app_ecommerce/screens/on_boarding/cubit/on_boarding_states.dart';
import 'package:admin_app_ecommerce/shared/components/custom_button.dart';
import '../../../shared/helper/methods.dart';
import '../../../shared/helper/size_config.dart';
import '../../../shared/styles/colors.dart';
import '../../login_register/complete_profile/complete_profile_screen.dart';
import '../../login_register/sign_in/sign_in_screen.dart';
import '../on_boarding_screen.dart';

// This is the best practice

class Body extends StatelessWidget {
  int currentPage = 0;
  var boardController = PageController();

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Diaa Hr Manger! Test 1 ",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
      "This The Project For Hr Manger ,, Diaa Test 2  , Lets Enjoy ",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "This The Project For Hr Manger ,, Diaa Test  3  , Lets Enjoy",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state ) {
        if (state is GoToSignIn) {
          navigateToAndFinish(context, SignInScreen());
        } else if (state is GoToHome) {
          navigateToAndFinish(context, MainLayout());
        } else if (state is GoToCompleteProfile) {
          navigateToAndFinish(context, CompleteProfileScreen());
        }
      },
      builder: (context, states) {
        OnBoardingCubit cubit = OnBoardingCubit.get(context);
        return Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == splashData.length - 1)
                    cubit.changePageViewState(true);
                  else
                    cubit.changePageViewState(false);
                },
                itemCount: splashData.length,
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]['text'],
                    ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    SmoothPageIndicator(
                      controller: boardController,
                      count: splashData.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: kPrimaryColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0,
                      ),
                    ),
                    Spacer(flex: 3),
                    CustomButton(text: 'Continue', press: (){
                      if (cubit.isLast) {
                        OnBoardingScreen.submit(context);
                       // cubit.checkNavigation();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    }),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
