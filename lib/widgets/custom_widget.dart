import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

String baseUrl = "http://temp.techsolutions-bd.com/api/admin/";
String imageUrl = "http://temp.techsolutions-bd.com/images/";

myStyle(double size, [Color? clr, FontWeight? fw]) {
  return GoogleFonts.roboto(fontSize: size, color: clr, fontWeight: fw);
}

var spinKit = SpinKitFadingFour(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);

final spin = SpinKitThreeInOut(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: index.isEven ? Colors.grey : Colors.blue,
      ),
    );
  },
);

showInToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}


