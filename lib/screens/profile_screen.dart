//import 'dart:html';

/*import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:healthapp/models/article_model.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/style/constant.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../shared/components/constant.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {


  String? uploadedImageUrl;

  Future<void> handleImageUpload() async {
    final imagePath = await selectImage();
    if (imagePath != null) {
      final imageUrl = await uploadImage(imagePath);
      setState(() {
        uploadedImageUrl = imageUrl;
      });
    }
  }


  Future<String?> selectImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return pickedFile.path;
  }

  return null;
}



Future<String?> uploadImage(String imagePath) async {
  if (imagePath.isEmpty) {
    return null;
  }

  try {
    final file = File(imagePath);
    final fileName = path.basename(file.path);
    final storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
    final uploadTask = storageRef.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(title: "بـيانـاتـي", context: context),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Stack(children: [
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    width: 128,
                    height: 128,
                    fit: BoxFit.contain,
                    image://uploadedImageUrl != null
             // ? NetworkImage(uploadedImageUrl!)as ImageProvider<Object>
              AssetImage("assets/images/user.png"),
                    child: InkWell(
                      onTap: (() {}),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(2),
                    color: Colors.white,
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: mainColor,
                        child: IconButton(
                            onPressed: (() {}),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "username",
                style: largeTextBold,
              )),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "email",
                style: normalTextRegular,
              )),
          SizedBox(
            height: 30,
          ),
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            width: 300,
            child: MaterialButton(
              onPressed: (() {}),
              color: mainColor,
              height: 60,
              child: Text(
                " تــعــديــل",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Tajwal',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/