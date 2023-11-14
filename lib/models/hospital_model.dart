import 'package:flutter/cupertino.dart';

class hospitalModel {
  String id;
  String imgAssetPath;
  String title;
  String description;
  // String email;
  String phone;
  String imageLocation;
  String address;

  hospitalModel({
    required this.id,
    required this.imgAssetPath,
    required this.title,
    required this.description,
    //required this.email,
    required this.phone,
    required this.imageLocation,
    required this.address,
  });

  factory hospitalModel.fromMap(Map<String, dynamic> map) => hospitalModel(
        id: (map["id"]),
        imgAssetPath: map["imgAssetPath"].toString(),
        title: map["title"].toString(),
        description: map["description"].toString(),
        // email: map["email"].toString(),
        phone: map["phone"].toString(),

        imageLocation: map["imageLocation"].toString(),
        address: map["address"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imgAssetPath": imgAssetPath,
        "title": title,
        "description": description,
       // "email": email,
        "phone": phone,
        "imageLocation": imageLocation,
        "address": address,
      };
}
