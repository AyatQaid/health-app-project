import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/screens/aboutApp_screen.dart';
import 'package:healthapp/screens/appointment_screen.dart';
import 'package:healthapp/screens/article_content_screen.dart';
import 'package:healthapp/screens/article_screen.dart';
import 'package:healthapp/screens/details_screen.dart';
import 'package:healthapp/screens/doctor_details_screen.dart';
import 'package:healthapp/screens/emergency_screen.dart';
import 'package:healthapp/screens/hospital_screen.dart';
import 'package:healthapp/screens/login_screen.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/screens/signup_screen.dart';
import 'package:healthapp/screens/splash_screen.dart';
import 'package:healthapp/screens/user_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHlper.init();

  await Firebase.initializeApp();
  // uid = CacheHlper.getData(key: "uid") ?? "";

  if (await CacheHlper.getData(key: "id") != null) {
    user = userModel(
      id: await CacheHlper.getData(key: 'id'),
      email: await CacheHlper.getData(key: 'email'),
      username: await CacheHlper.getData(key: 'username'),
      password: await CacheHlper.getData(key: 'password'),
    );
  }
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashPage(),
    );
  }
}
