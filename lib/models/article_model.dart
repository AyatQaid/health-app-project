import 'package:flutter/cupertino.dart';

class articleModel {
  String id;
  String imgAssetPath;
  String title;
  String subtitle;

  articleModel(
      {required this.id,
      required this.imgAssetPath,
      required this.title,
      required this.subtitle});

  factory articleModel.fromMap(Map<String, dynamic> map) => articleModel(
        id:(map["id"]),
        imgAssetPath: map["imgAssetPath"].toString(),
        title: map["title"].toString(),
        subtitle: map["subtitle"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imgAssetPath": imgAssetPath,
        "title": title,
        "subtitle": subtitle,
      };
}
