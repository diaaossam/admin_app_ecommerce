import 'package:admin_app_ecommerce/screens/login_register/register/components/register.form.dart';
import 'package:flutter/material.dart';

import '../../../../shared/helper/size_config.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            RegisterForm(),
            SizedBox(height: SizeConfig.bodyHeight * 0.08),
          ],
        ),
      ),
    );
  }
}
