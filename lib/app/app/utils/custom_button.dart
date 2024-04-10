import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.buttonText,
      this.fontSize,
      this.fontColor,
      this.fontWeight,
      this.buttonHeight,
      this.isLoading = false,
      this.borderRadius,
      this.btnBgColor,
      this.onPressed,
      this.buttonWidth})
      : super(key: key);
  final String buttonText;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? borderRadius;
  final Color? btnBgColor;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 48,
      width: buttonWidth ?? double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColors.shadowBgColor.withOpacity(0.25), blurRadius: 10)
      ]),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  btnBgColor ?? AppColors.black.withOpacity(0.9)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(borderRadius ?? 10.0)))),
          onPressed: isLoading? null: onPressed,
          child: isLoading?
          const CupertinoActivityIndicator(
            radius: 15,
            color: AppColors.white,
          ):
          Text(
            buttonText,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.w500,
              color: fontColor ?? AppColors.white,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
