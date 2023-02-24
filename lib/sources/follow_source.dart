import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:discuss_app/config/api.dart';
import 'package:http/http.dart';

import '../models/users.dart';

class FollowSource {
  static Future<bool> checkIsFollowing(
    String fromIdUser,
    String toIdUser,
  ) async {
    String url = '${Api.follows}/check.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - Check Is Following', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Follow Source - Check Is Following', e.toString());
      return false;
    }
  }

  static Future<bool> following(
    String fromIdUser,
    String toIdUser,
  ) async {
    String url = '${Api.follows}/following.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - Following', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Follow Source - Following', e.toString());
      return false;
    }
  }

  static Future<bool> unfollow(
    String fromIdUser,
    String toIdUser,
  ) async {
    String url = '${Api.follows}/unfollow.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - Unfollow', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Follow Source - Unfollow', e.toString());
      return false;
    }
  }

  static Future<List<Users>> showFollower(String idUser) async {
    String url = '${Api.follows}/showFollower.php';
    try {
      Response response =
          await Client().post(Uri.parse(url), body: {'id_user': idUser});
      DMethod.printTitle('Follow Source - Show Follower', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Users.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Follow Source - Show Follower', e.toString());
      return [];
    }
  }

  static Future<List<Users>> showFollowing(String idUser) async {
    String url = '${Api.follows}/showFollowing.php';
    try {
      Response response =
          await Client().post(Uri.parse(url), body: {'id_user': idUser});
      DMethod.printTitle('Follow Source - Show Following', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Users.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Follow Source - Show Following', e.toString());
      return [];
    }
  }
}
