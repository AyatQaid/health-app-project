import 'package:flutter/cupertino.dart';

class doctorModel {
  String id;
  String imgAssetPath;
  String title;
  String description;


  doctorModel(
      {required this.id, required this.imgAssetPath, required this.title,required this.description});

  factory doctorModel.fromMap(Map<String, dynamic> map) => doctorModel(
        id: (map["id"]),
        imgAssetPath: map["imgAssetPath"].toString(),
        title: map["title"].toString(),
                description: map["description"].toString(),

      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imgAssetPath": imgAssetPath,
        "title": title,
      };
}

