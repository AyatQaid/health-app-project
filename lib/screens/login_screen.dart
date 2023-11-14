import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/screens/signup_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/network/local/cache_helper.dart';
import 'package:healthapp/shared/style/constant.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool psw = false;
  bool isLoading = false;
  var emailController = TextEditingController();
  var pswController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  /* void dispose() {
    emailController.dispose();
    pswController.dispose();
    super.dispose();
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Container(
              width: 50,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(30))),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        height: 200,
                        image: AssetImage('assets/images/wallpaper.png')),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "تــسـجـيل الدخــول",
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: ' الايـمـيـل',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'الحـقـل فـارغ';
                          } else if (!emailValidate(value)) {
                            return 'ادخــل ايـمـيل صـحـيح';
                          } else {
                            return null;
                          }
                        },
                        prefix: Icons.email),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: pswController,
                      type: TextInputType.text,
                      label: 'كــلمــة الـسـر',
                      isPassword: true,
                      validate: ((value) {
                        if (value!.isEmpty)
                          return "! الـحـقـل فـارغ";
                        else if (value.length < 8)
                          return "كلمة السر يجب أن تـكون اكـثـر من 8 احرف";
                      }),
                      prefix: Icons.remove_red_eye_outlined,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            width: 600,
                            child: MaterialButton(
                                color: mainColor,
                                height: 60,
                                child: Text(
                                  "تــســجــيل الدخــول",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: emailController.text,
                                            password: pswController.text)
                                        .then((value) {
                                      if (value.user != null) {
                                        uid = value.user!.uid.toString();
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(uid)
                                            .get()
                                            .then((value) {
                                          if (value.data() != null) {
                                            user = userModel
                                                .fromMap(value.data()!);
                                            Navigator.pop(context);

                                            CacheHlper.putData(
                                                key: "id", value: user!.id);
                                            CacheHlper.putData(
                                                key: 'username',
                                                value: user!.username);
                                            CacheHlper.putData(
                                                key: 'email',
                                                value: user!.email);
                                            CacheHlper.putData(
                                                key: 'password',
                                                value: user!.password);
                                          }
                                        });
                                      }
                                      print(value.user!.uid);
                                    }).catchError((error) {
                                      print(error.toString());
                                    });
                                  }
                                }),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "ـــــــــــــــــــ أو سجـل الـدخـول باسـتـخـدام ـــــــــــــــ",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: mainColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 25,
                          child: IconButton(
                            onPressed: signInWithGoogle,
                            icon: Image.asset(
                              "assets/images/gmail.png",
                              width: 30,
                              height: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            navigateToandFinish(context, signupPage());
                              },
                          child: Text("أنــشـى حـسـاب",
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Text(
                          " لا تــمــلك حـسـاب ؟",
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ));
  }
}

bool emailValidate(String email) {
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return true;
  } else {
    return false;
  }
}

Future<void> signInWithGoogle() async {
  try {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Successfully signed in with Gmail
        // Do something with the user object
      } else {
        // Sign in failed
      }
    } else {
      // Google sign in canceled by user
    }
  } catch (e) {
    // Handle any errors
  }
}