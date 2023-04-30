import 'package:flutter/material.dart';

class Custom_Text_Field extends StatelessWidget {
  Custom_Text_Field({
    super.key, this.icon,this.preicon, required this.text, required this.controller,
  });
  String text;
  var icon,preicon,controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
      child:  TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(icon)
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(preicon)
          ),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}