import 'package:admin_app_ecommerce/screens/main_screens/add_product/cubit/add_product_cubit.dart';
import 'package:admin_app_ecommerce/shared/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropDownCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit,AddProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'Select Item Category',
              style: TextStyle(
                fontSize: getProportionateScreenHeight(20.0),
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: AddProductCubit
                .get(context)
                .categoryList
                .map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize:getProportionateScreenHeight(20.0),
                    ),
                  ),
                ))
                .toList(),
            value: AddProductCubit
                .get(context)
                .categoryText,
            onChanged: (value) {
              AddProductCubit.get(context).changeCategory(value as String);
            },
            buttonHeight: getProportionateScreenHeight(50.0),
            buttonWidth: getProportionateScreenHeight(240),
            itemHeight: getProportionateScreenHeight(50.0),
          ),
        );
      },
    );
  }
}