import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/users.dart';

class Session {
  static Future<Users?> getUser() async {
    Users? currentUser;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      currentUser = Users.fromJson(mapUser);
    }
    return currentUser;
  }

  static Future<bool> setUser(Users user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    return await pref.setString('user', stringUser);
  }

  static Future<bool> clearUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove('user');
  }
}
