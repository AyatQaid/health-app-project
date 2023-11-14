import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHlper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> putData({
    required String key,
    required dynamic value,
  }) {
    if (value is bool)
      return sharedPreferences.setBool(key, value);
    else if (value is double)
      return sharedPreferences.setDouble(key, double.parse(value.toString()));
    else if (value is int)
      return sharedPreferences.setInt(key, value);
    else
      return sharedPreferences.setString(key, value.toString());
  }
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }
  static Future<bool> removeData({
    required String key,
  }) async {
    print("the key remove $key");
    return await sharedPreferences.remove(key);

  }


}

 /*static Future<void> signOut() async {
    // Clear the user data from SharedPreferences

    await removeData(key: 'id');
    await removeData(key: 'email');
    await removeData(key: 'username');
    await removeData(key: 'password');

    // Sign out the user from Firebase
  }
*/