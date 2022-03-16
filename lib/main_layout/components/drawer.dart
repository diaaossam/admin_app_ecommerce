import 'package:flutter/material.dart';

import '../../models/menu_items.dart';
import '../../shared/helper/size_config.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: SizeConfig.bodyHeight * 0.05,
          ),
          Center(
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: SizeConfig.bodyHeight * .115,
                      backgroundColor: kPrimaryColor,
                    ),
                    CircleAvatar(
                      radius: SizeConfig.bodyHeight * .11,
                      backgroundColor: Colors.white,
                      backgroundImage: /*imageProfile == null
                            ? NetworkImage(
                            '${MainLayoutCubit.get(context).userModel!.image}')
                            : FileImage(imageProfile)
                        as ImageProvider*/
                          NetworkImage('d'),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: getProportionateScreenHeight(25.0),
                  child: IconButton(
                      onPressed: () {
                        /*MainLayoutCubit.get(context)
                            .getProfileImage();*/
                      },
                      icon: Icon(Icons.camera_alt)),
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * 0.03,
          ),
          Center(
            child: Text(
              'Diaa Ghozlan' /*'${MainLayoutCubit.get(context).userModel!.firstName} ${MainLayoutCubit.get(context).userModel!.lastName} '*/,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(23.0),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * 0.08,
          ),
          Container(
            width: SizeConfig.screenWidth * 0.55,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: menuItemList.length,
                itemBuilder: (context, index) =>
                    menuItme(menuItemList[index], () {
                      /* cubit.setScreen(index);
                      Navigator.pop(context);*/
                    })),
          ),
        ],
      ),
    );
  }

  List<MenuItems> menuItemList = [
    MenuItems(icon: IconBroken.Download, title: 'Dash Board'),
    MenuItems(icon: IconBroken.Paper_Negative, title: 'Add Product'),
    MenuItems(icon: IconBroken.Category, title: 'Add Category'),
    MenuItems(icon: IconBroken.Bag, title: 'Add brand'),
    MenuItems(icon: IconBroken.More_Circle, title: 'Add New'),
    MenuItems(icon: IconBroken.Logout, title: 'Log out'),
  ];

  Widget menuItme(MenuItems items, onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(items.icon, size: getProportionateScreenHeight(30.0)),
              SizedBox(
                width: getProportionateScreenHeight(15.0),
              ),
              Text(
                items.title,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(23.0),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
