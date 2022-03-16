import 'package:admin_app_ecommerce/models/Product.dart';
import 'package:admin_app_ecommerce/shared/components/custom_button.dart';
import 'package:admin_app_ecommerce/shared/helper/size_config.dart';
import 'package:admin_app_ecommerce/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../../../shared/helper/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';
import 'componant/drop_category.dart';
import 'cubit/add_product_cubit.dart';

class AddNewProductScreen extends StatelessWidget {
  var title = TextEditingController();
  var descritption = TextEditingController();
  var price = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          AddProductCubit cubit = AddProductCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(20.0),
                        horizontal: getProportionateScreenHeight(20.0)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(20.0),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.getproductImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                            ),
                            width: SizeConfig.bodyHeight * 0.3,
                            height: SizeConfig.bodyHeight * 0.3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(
                                      18.0)),
                              child: cubit.productImage != null
                                  ? Image(image: FileImage(cubit.productImage!),
                                fit: BoxFit.cover,)
                                  : Icon(
                                CupertinoIcons.camera,
                                size: getProportionateScreenHeight(100.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20.0),
                        ),
                        buildCheckBoxPopulerandCategory(cubit),
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),
                        buildProductTitleFormField(cubit),
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),
                        buildProductDescprtionFormField(cubit),
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(80.0)),
                          child: buildProductPriceFormField(cubit),
                        ),
                        SizedBox(height: getProportionateScreenHeight(50.0),),
                        CustomButton(
                            text: 'Confirm',
                            press: () {
                              if (formKey.currentState!.validate())
                                if (cubit.categoryText == null) {
                                  Toast.show(
                                      'Please Select Category Type', context,
                                      gravity: Toast.bottom);
                                } else if (cubit.productImage == null) {
                                  Toast.show(
                                      'Please Select Product Image', context,
                                      gravity: Toast.bottom);
                                } else {
                                  cubit.uploadProduct(
                                      type: cubit.categoryText!,
                                      map: {
                                        '${productId}': DEFULT,
                                        '${productTitle}': title.text,
                                        '${productDescription}': descritption
                                            .text,
                                        '${productImages}': DEFULT,
                                        '${productId}': DEFULT,
                                        '${productRating}': 0.0,
                                        '${productPrice}': price.text,
                                        '${productIsFavourite}': false,
                                        '${productIsPopular}': cubit.isPopuler,
                                      });
                                  Navigator.pop(context);
                                }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField buildProductTitleFormField(AddProductCubit cubit) {
    return TextFormField(
      controller: title,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Product Title";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineInputBorder(),
        labelText: "Product Title",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(IconBroken.Ticket),
      ),
    );
  }

  TextFormField buildProductDescprtionFormField(AddProductCubit cubit) {
    return TextFormField(
      controller: descritption,
      maxLines: 3,
      keyboardType: TextInputType.text,

      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Product Descrption";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineInputBorder(),
        labelText: "Product Description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(IconBroken.Ticket),
      ),
    );
  }

  TextFormField buildProductPriceFormField(AddProductCubit cubit) {
    return TextFormField(
      controller: price,
      maxLines: 1,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Product Price";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineInputBorder(),
        labelText: "Product Price",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(IconBroken.Ticket),
      ),
    );
  }

  Widget buildCheckBoxPopulerandCategory(AddProductCubit cubit){
    return  Row(
      children: [
        DropDownCategory(),
        Checkbox(
          value: cubit.isPopuler,
          activeColor: kPrimaryColor,
          onChanged: (value) {
            cubit.changePopuler();
          },
        ),
        Text("Is Populer", style: TextStyle(
          fontSize: getProportionateScreenHeight(18.0)
        ),),
      ],
    );
  }
}
