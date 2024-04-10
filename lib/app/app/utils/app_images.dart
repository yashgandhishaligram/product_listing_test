import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppImages {
  //SVG Images
  static const homeIcon = "assets/svg/home.svg";

  static Widget getPNGImage(String image, double width, double height) {
    return Image.asset(image,
        height: height,
        width: width);
  }

  static Widget getNetWorkImage(String image, double width, double height) {
    return Image.network(image,
        height: height,
        width: width);
  }

}
