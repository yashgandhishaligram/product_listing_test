import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(this.text,
      {Key? key,
      this.style,
      this.overflow,
      this.maxLines,
      this.textAlign,
      this.fontSize,
      this.fontColor,
      this.textScaleFactor,
      this.fontWeight})
      : super(key: key);
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? fontColor;
  final TextScaler? textScaleFactor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: textScaleFactor,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
