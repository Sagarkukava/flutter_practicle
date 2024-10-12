
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {

  static fieldFocuschange(BuildContext context,
      FocusNode current,
      FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void flushbarErrormessage(String message, BuildContext context){
   showFlushbar(context: context, flushbar: Flushbar(
     forwardAnimationCurve:Curves.decelerate,
     margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
     padding: EdgeInsets.all(15),
     message: message,
     duration: Duration(seconds: 2),
     borderRadius: BorderRadius.circular(20),
     backgroundColor: Colors.red,
     flushbarPosition: FlushbarPosition.TOP,
     reverseAnimationCurve: Curves.easeInOut,
     positionOffset: 20,
     icon: Icon(Icons.error,color: Colors.white,),
   )..show(context));
  }
}