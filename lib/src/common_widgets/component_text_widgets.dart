import 'package:ecommerce_app/src/constants/constants_colors.dart';
import 'package:flutter/material.dart';

class ComponentText {
  static Widget buildTextWidget(
      {required String title,
      TextAlign textAlign = TextAlign.start,
      TextOverflow overflow = TextOverflow.ellipsis,
      int maxLines = 1,
      bool softWrap = false,
      Color color = ConstantColor.primaryColor,
      double fontSize = 15.0,
      FontWeight fontWeight = FontWeight.normal,
      TextDecoration textDecoration = TextDecoration.none}) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: TextStyle(
        decoration: textDecoration,
        color: color,
        fontSize: fontSize,
        fontFamily: 'Roboto',
        fontWeight: fontWeight,
      ),
    );
  }
}
