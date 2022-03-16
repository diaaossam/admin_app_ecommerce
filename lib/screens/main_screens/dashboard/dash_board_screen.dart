import 'package:admin_app_ecommerce/main_layout/cubit/main_layout_cubit.dart';
import 'package:admin_app_ecommerce/screens/main_screens/add_product/add_product_screen.dart';
import 'package:admin_app_ecommerce/shared/helper/methods.dart';
import 'package:admin_app_ecommerce/shared/helper/size_config.dart';
import 'package:admin_app_ecommerce/shared/styles/colors.dart';
import 'package:admin_app_ecommerce/shared/styles/icon_broken.dart';
import 'package:admin_app_ecommerce/shared/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/Product.dart';
import '../../../shared/components/custom_card.dart';
import '../../../main_layout/cubit/main_layout_state.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainLayoutCubit, MainLayoutState>(
      listener: (context, state) {
        if (state is GetAllUserLoading) {
          showCustomProgressIndicator(context);

        }
      },
      builder: (context, state) {
        MainLayoutCubit cubit = MainLayoutCubit.get(context);
        return state is GetAllUserLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.bodyHeight * 0.01,
                            ),
                            Text('Welcome Diaa ',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize:
                                        getProportionateScreenHeight(30.0),
                                    fontWeight: FontWeight.w700)),
                            SizedBox(
                              height: SizeConfig.bodyHeight * 0.05,
                            ),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: .85,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                children: <Widget>[
                                  CardItem(
                                    text: 'Users',
                                    iconData: IconBroken.User1,
                                    number: cubit.list.length,
                                    onTap: () {
                                      navigateTo(context, AddNewProductScreen());
                                      /*cubit.uploadProduct(
                                          type: 'Diaa',
                                          section: 'Diaa2',
                                          productModel: demoProducts[0]);*/
                                    },
                                  ),
                                  CardItem(
                                    text: 'Category',
                                    iconData: IconBroken.Category,
                                    number: 7,
                                    onTap: () {},
                                  ),
                                  CardItem(
                                    text: 'Products',
                                    iconData: Icons
                                        .production_quantity_limits_outlined,
                                    number: 7,
                                    onTap: () {},
                                  ),
                                  CardItem(
                                    text: 'Sold',
                                    iconData: Icons.sell_outlined,
                                    number: 7,
                                    onTap: () {},
                                  ),
                                  CardItem(
                                    text: 'Orders',
                                    iconData: IconBroken.More_Circle,
                                    number: 7,
                                    onTap: () {},
                                  ),
                                  CardItem(
                                    text: 'Returned',
                                    iconData: IconBroken.Arrow___Left_2,
                                    number: 7,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
      },
    );
  }
}
