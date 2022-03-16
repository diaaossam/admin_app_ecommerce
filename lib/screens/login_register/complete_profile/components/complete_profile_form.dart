import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app_ecommerce/main_layout/main_layout.dart';
import 'package:admin_app_ecommerce/models/user_model.dart';
import 'package:admin_app_ecommerce/shared/components/custom_button.dart';
import 'package:admin_app_ecommerce/shared/helper/methods.dart';
import 'package:admin_app_ecommerce/shared/styles/styles.dart';

import '../../../../shared/components/custom_surfix_icon.dart';
import '../../../../shared/components/form_error.dart';
import '../../../../shared/helper/constants.dart';
import '../../../../shared/helper/size_config.dart';
import '../../../../shared/widgets/custom_widgets.dart';
import '../cubit/complete_profile_cubit.dart';
import '../cubit/complete_profile_state.dart';


class CompleteProfileForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();

  void addError({required CompleteProfileCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required CompleteProfileCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is LoadingUploadUserInfoCompleteProfile) {
          showCustomProgressIndicator(context);
        } else if (state is ErrorUploadUserInfoCompleteProfile) {
          Navigator.pop(context);
          String errorMsg = state.errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 5),
          ));
        } else if (state is SucessUploadUserInfoCompleteProfile) {
          navigateToAndFinish(context, MainLayout());
        }
      },
      builder: (context, state) {
        CompleteProfileCubit cubit = CompleteProfileCubit.get(context);
        return Form(
          key: _formKey,
          child: Column(
            children: [
              buildFirstNameFormField(cubit),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildLastNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPhoneNumberFormField(cubit),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildAddressFormField(cubit),
              FormError(errors: cubit.errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomButton(
                  text: 'Continue',
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.setUserInfo(
                          userModel: UserModel(
                        uid: cubit.getLoggedInUser().uid,
                        image: DefultImage,
                        firstName: firstName.text,
                        lastName: lastName.text,
                        phone: phoneNumber.text,
                        address: address.text,
                        isAdmin: true,
                      ));
                    }
                  })
            ],
          ),
        );
      },
    );
  }

  TextFormField buildFirstNameFormField(CompleteProfileCubit cubit) {
    return TextFormField(
      controller: firstName,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineInputBorder(),
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastName,
      decoration: InputDecoration(
        border: outlineInputBorder(),
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField(CompleteProfileCubit cubit) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: phoneNumber,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineInputBorder(),
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField(CompleteProfileCubit cubit) {
    return TextFormField(
      controller: address,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(cubit: cubit, error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(cubit: cubit, error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineInputBorder(),
        labelText: "Address",
        hintText: "Enter your phone address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }
}
