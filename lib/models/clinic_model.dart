import 'package:flutter/cupertino.dart';

class clinicModel {
  String id;
  String imgAssetPath;
  String title;
  String description;
      String imageLocation;

  String phone;
  String address;
  clinicModel({
    required this.id,
    required this.imgAssetPath,
    required this.title,
    required this.description,
    required this.phone,
   required this.imageLocation,
    required this.address,
  });

  factory clinicModel.fromMap(Map<String, dynamic> map) => clinicModel(
        id: (map["id"]),
        imgAssetPath: map["imgAssetPath"].toString(),
        title: map["title"].toString(),
        description: map["description"].toString(),
        phone: map["phone"].toString(),
        imageLocation: map["imageLocation"].toString(),

        address: map["address"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imgAssetPath": imgAssetPath,
        "title": title,
        "description": description,
        "imageLocation": imageLocation,
        "phone": phone,
        "address": address,
      };
}
