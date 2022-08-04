import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateAndFinish(context, screen) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false);
}

void navigateTo(context, screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void showToast({
      @required String text,
      @required ToastStates state,
}) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color  chooseToastColor(ToastStates state){
Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color =  Colors.yellow;
      break;
  }
  return color;
}