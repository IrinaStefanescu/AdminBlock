import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final VoidCallback action;
  final EdgeInsets margin;
  final double fontSize;
  final Color fontColor;
  final BorderRadius borderRadius;
  final Color borderSideColor;
  final FontWeight fontWeight;
  final Color foregroundColor;
  final Color backgroundColor;

  const ButtonPrimary({
    Key? key,
    required this.title,
    required this.action,
    required this.fontSize,
    required this.fontColor,
    required this.fontWeight,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.margin,
    required this.borderRadius,
    required this.borderSideColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextButton(
        onPressed: action,
        child: Text(
          title,
          style: TextStyle(
              fontSize: fontSize, color: fontColor, fontWeight: fontWeight),
        ),
        style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.all<Size>(Size(double.infinity, 52)),
            foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: borderRadius,
                    side: BorderSide(color: borderSideColor)))),
      ),
    );
  }
}
