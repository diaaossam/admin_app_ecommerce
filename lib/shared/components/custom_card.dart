import 'package:admin_app_ecommerce/shared/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/size_config.dart';

class CardItem extends StatelessWidget {
  String text;
  IconData iconData;
  int number;
  final onTap;


  CardItem({required this.text,required  this.iconData,required  this.number,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child:  Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14),
              vertical: getProportionateScreenHeight(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Icon(iconData, size: getProportionateScreenHeight(35.0)),
                    SizedBox(
                      width: getProportionateScreenHeight(10.0),
                    ),
                    Text(text,
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(22.0),
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                ),
                SizedBox(height: getProportionateScreenWidth(25)),
                AppText(
                  text: '${number}',
                  fontSize: getProportionateScreenHeight(70),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
