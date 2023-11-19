import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/screens/appointment_screen.dart';
import 'package:healthapp/screens/article_screen.dart';
import 'package:healthapp/screens/clinics_screen.dart';
import 'package:healthapp/screens/doctor_screen.dart';
import 'package:healthapp/screens/emergency_screen.dart';
import 'package:healthapp/screens/hospital_screen.dart';
import 'package:healthapp/screens/lab_screen.dart';
import 'package:healthapp/screens/login_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/network/local/cache_helper.dart';
import 'package:healthapp/shared/style/constant.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../shared/network/local/cache_helper.dart';
import '../shared/network/local/cache_helper.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  
  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          selectedItemColor: mainColor,
          unselectedItemColor: mainColor,
          backgroundColor: Colors.grey.shade200,
          elevation: 2,
          items: [
            BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    navigateTo(context, emergencyPage());
                  },
                  child: Image.asset(
                    "assets/images/emergency.png",
                    width: 30,
                    height: 30,
                  ),
                ),
                label: "الــطــوارئ"),
            BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    if (user != null)
                      navigateTo(context, articlesPage());
                    else 
                      navigateTo(context, loginPage());
                      
                   // navigateTo(context, articlesPage());
                  },
                  child: Image.asset(
                    "assets/images/article.png",
                    width: 30,
                    height: 30,
                  ),
                ),
                label: "الــمـقـالات"),
            BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    navigateTo(context, mainPage());
                  },
                  child: Image.asset(
                    "assets/images/home.png",
                    width: 30,
                    height: 30,
                  ),
                ),
                label: " الـرئيسيـة"),
          ],
        ),
        backgroundColor: Colors.white,
        appBar: mainPageAppBar(),
        endDrawer: navigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(" دلـيلك للمـنـشأت الطـبـية في عــدن  ",
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 25,
                      fontWeight: FontWeight.normal)),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, hospitalPage());
                      },
                      child: Container(
                          height: 130,
                          width: 80,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 0,
                                  // offset: Offset(0, 1),
                                  color: Colors.grey)
                            ],
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.yellow.shade500,
                          ),
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/hospital.png",
                                width: 60,
                                height: 60,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "مستشفيات",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, clinicPage());
                      },
                      child: Container(
                          height: 130,
                          width: 80,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 2,
                                // offset: Offset(0, 1),
                                color: Colors.grey,
                              )
                            ],
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blueAccent.shade100,
                          ),
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/clinic.png",
                                width: 60,
                                height: 60,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "عــيــادات",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, labPage());
                      },
                      child: Container(
                          height: 130,
                          width: 80,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 0,
                                  // offset: Offset(0, 1),
                                  color: Colors.grey)
                            ],
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 62, 212, 32),
                          ),
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/lab3.png",
                                width: 60,
                                height: 60,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "مــخـتـبـرات",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, doctorPage());
                      },
                      child: Container(
                          height: 130,
                          width: 80,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 2,
                                // offset: Offset(0, 1),
                                color: Colors.grey,
                              )
                            ],
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 224, 35, 183),
                          ),
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/medical-team.png",
                                width: 60,
                                height: 60,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "أطـــبــاء",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontFamily: 'Tajawal',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

AppBar mainPageAppBar() => AppBar(
      iconTheme: IconThemeData(color: mainColor),
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
            fit: BoxFit.contain,
            height: 2000,
            width: 2000,
            image: AssetImage('assets/images/logo.png')),
      ),
      title: Center(
          child: Text(
        "تــطـبــيــق صـــحـــة",
        style: TextStyle(
            color: mainColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal'),
      )),
    );
