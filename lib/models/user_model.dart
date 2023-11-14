import 'package:flutter/cupertino.dart';

class userModel {
  String id;
  String username;
  String email;
  String password;

  userModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.password});

  factory userModel.fromMap(Map<String, dynamic> map) => userModel(
        id:map["id"],
        username: map["username"].toString(),
        email: map["email"].toString(),
        password: map["password"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
      };
}
