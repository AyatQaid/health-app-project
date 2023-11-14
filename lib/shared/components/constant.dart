import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/models/article_model.dart';
import 'package:healthapp/models/clinic_model.dart';
import 'package:healthapp/models/doctor_model.dart';
import 'package:healthapp/models/emergency_model.dart';
import 'package:healthapp/models/hospital_model.dart';
import 'package:healthapp/models/lab_model.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/screens/article_screen.dart';
import 'package:healthapp/screens/user_screen.dart';
import 'package:healthapp/shared/style/constant.dart';



import 'package:flutter/cupertino.dart';

//String keyIsDark = "isdark";
String keyToken = "token";
String token = "";

String uid = "";
userModel? user;

String weekNoToName(String no){
  if(no=="1")
  return "السبت";
else if(no=="2")
  return "الاحد";
  else if (no=="3")
  return "الاثنين";
  else if (no=="4")
  return "الثلاثاء";
  else if (no=="5")
  return "الاربعاء";
  else if (no=="6")
  return "الخميس";
  else if (no=="7")
  return "الجمعة";
  else return "";
}
navigateTo(context, widget) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
      ));
}

navigateToandFinish(context, widget) {
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
      ));
}
