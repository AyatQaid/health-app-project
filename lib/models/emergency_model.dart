import 'package:flutter/cupertino.dart';

class emergencyModel {
  String id;
  String title;
  String phone;
  emergencyModel({required this.id, required this.title, required this.phone});

  factory emergencyModel.fromMap(Map<String, dynamic> map) => emergencyModel(
        id: map["id"].toString(),
        title: map["title"].toString(),
        phone: map["phone"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "phone": phone,
      };
}
