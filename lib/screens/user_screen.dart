//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/screens/myAppointment.dart';
import 'package:healthapp/screens/myfavorites_screen.dart';
import 'package:healthapp/screens/profile_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/network/local/cache_helper.dart';
import 'package:healthapp/shared/style/constant.dart';

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: appBarComponent(title: "مــعــلوماتــي", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    user!.username,
                    style: largeTextBold,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                      radius: 50,
                      child: Image(
                        image: AssetImage('assets/images/user.png'),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey.shade200,
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  //navigateTo(context, profilePage());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: mainColor,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "بــيــانــاتــي",
                        style: mediumTextRegular,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  navigateTo(context, myFavoritesPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            navigateTo(context, myFavoritesPage());
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: mainColor,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "مــفــضــلاتــي",
                        style: mediumTextRegular,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  navigateTo(context, myAppointmentPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            navigateTo(context, myAppointmentPage());
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: mainColor,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "مــواعــيــدي",
                        style: mediumTextRegular,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                /*  if (CacheHlper.getData(key: "id") != null) {
                    user = userModel(
                      id: CacheHlper.getData(key: 'id'),
                      email: CacheHlper.getData(key: 'email'),
                      username: CacheHlper.getData(key: 'username'),
                      password: CacheHlper.getData(key: 'password'),
                    );
                    print("sssss");
                  }*/
                  await CacheHlper.removeData(key: "id").then((value) {
                    print(value);
                    if (value == true) {
                      Navigator.pop(context);
                      navigateToandFinish(context, mainPage());
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () async {},
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: mainColor,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "تـسـجـيل الـخـروج",
                        style: mediumTextRegular,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
