import 'package:flutter/material.dart';

class Custom_Button extends StatelessWidget {
  Custom_Button({
    super.key,required this.text,required this.backgroundColor,required this.foregroundColor,required this.onTap
  });
  String text;
  int backgroundColor , foregroundColor;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor:  Color(foregroundColor),
          backgroundColor: Color(backgroundColor),
          side: const BorderSide(
            color: Color(0xff272727),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(text),
      ),
    );
  }
}