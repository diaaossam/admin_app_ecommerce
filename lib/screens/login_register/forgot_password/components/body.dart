import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app_ecommerce/shared/components/custom_button.dart';
import 'package:admin_app_ecommerce/shared/styles/styles.dart';

import '../../../../shared/components/custom_surfix_icon.dart';
import '../../../../shared/components/form_error.dart';
import '../../../../shared/components/no_account_text.dart';
import '../../../../shared/helper/constants.dart';
import '../../../../shared/helper/size_config.dart';
import '../../../../shared/widgets/custom_widgets.dart';
import '../cubit/forget_cubit.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.bodyHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.bodyHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetCubit(),
      child: BlocConsumer<ForgetCubit, ForgetState>(
        listener: (context, state) {

          if(state is SendResetEmailLoading){
            showCustomProgressIndicator(context);
          }
          else if(state is SendResetEmailError){
            Navigator.pop(context);
            String errorMsg = state.errorMsg;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ));
          }
          else if(state is SendResetEmailSuccess){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Reset Eamil SentSuccessfully'),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ));
            Future.delayed(Duration(seconds: 1),(){
              Navigator.pop(context);
            });

          }
        },
        builder: (context, state) {
          ForgetCubit cubit = ForgetCubit.get(context);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    if (value.isNotEmpty &&
                        cubit.errors.contains(kEmailNullError)) {
                      cubit.removeError(error: kEmailNullError);
                    } else if (emailValidatorRegExp.hasMatch(value) &&
                        cubit.errors.contains(kInvalidEmailError)) {
                      cubit.removeError(error: kInvalidEmailError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value!.isEmpty &&
                        !cubit.errors.contains(kEmailNullError)) {
                      cubit.setError(error: kEmailNullError);
                    } else if (!emailValidatorRegExp.hasMatch(value) &&
                        !cubit.errors.contains(kInvalidEmailError)) {
                      cubit.setError(error: kInvalidEmailError);
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: outlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter your email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon:
                        CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                FormError(errors: cubit.errors),
                SizedBox(height: SizeConfig.bodyHeight * 0.2),
                CustomButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.resetUserPassword(email: email.text);
                    }
                  },
                ),
                SizedBox(height: SizeConfig.bodyHeight * 0.1),
                NoAccountText(),
              ],
            ),
          );
        },
      ),
    );
  }
}
