import 'package:admin_app_ecommerce/screens/login_register/register/cubit/regsiter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app_ecommerce/shared/components/custom_button.dart';
import '../../../../shared/components/custom_surfix_icon.dart';
import '../../../../shared/components/form_error.dart';
import '../../../../shared/helper/constants.dart';
import '../../../../shared/helper/size_config.dart';
import '../../../../shared/widgets/custom_widgets.dart';
import '../cubit/register_state.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;

  void addError({required RegisterCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required RegisterCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadingState)
            showCustomProgressIndicator(context);
          else if (state is RegisterSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state is RegisterFailuerState) {
            Navigator.pop(context);
            String errorMsg = state.errorMsg;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ));
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildEmailFormField(cubit),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(cubit),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildConformPassFormField(cubit),
                SizedBox(height: getProportionateScreenHeight(30)),
                FormError(errors: cubit.errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                CustomButton(
                    text: "Register",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        cubit.regiterNewUser(
                            email: email!, password: password!);
                      }
                    }),
              ],
            ),
          );
        },
      ),
    );
  }

  TextFormField buildConformPassFormField(RegisterCubit cubit) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(cubit: cubit, error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(cubit: cubit, error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField(RegisterCubit cubit) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(cubit: cubit, error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(cubit: cubit, error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField(RegisterCubit cubit) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError, cubit: cubit);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(cubit: cubit, error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(cubit: cubit, error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }


}
