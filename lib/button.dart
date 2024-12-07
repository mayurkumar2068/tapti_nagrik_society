import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Color backgroundColor;
  final Color? textColor;
  final Color borderColor;
  final VoidCallback onPressed;
  final double elevation;
  final double fontSize;
  final double width;
  final double height;
  final Icon? icon;

  const CustomButton({
    Key? key,
    this.icon,
    this.title,
    required this.onPressed,
    required this.backgroundColor,
    this.textColor,
    required this.borderColor,
    this.elevation = 2.0,
    this.fontSize = 16.0,
    this.width = 300,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null && title != null) SizedBox(width: 8),
            if (title != null)
              Text(
                title!,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
