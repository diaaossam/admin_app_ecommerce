
import 'package:flutter/material.dart';

import '../helper/size_config.dart';
import '../styles/colors.dart';

class AppText extends StatelessWidget {
  String text;
  bool isDark;

  double? fontSize;

  AppText({required this.text, this.isDark = false, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        fontSize: fontSize == null
            ? getProportionateScreenHeight(15.0)
            : getProportionateScreenHeight(fontSize!),
        color: isDark ? Colors.white:darkThemeColor  ,
      ),
    );
  }
}
