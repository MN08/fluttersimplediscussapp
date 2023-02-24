import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:discuss_app/config/api.dart';
import 'package:discuss_app/models/users.dart';
import 'package:http/http.dart';

class UserSource {
  static Future<Map> register(String username, String password) async {
    String url = '${Api.users}/register.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'username': username,
        'password': password,
      });
      DMethod.printTitle('User Source - Register', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      DMethod.printTitle('User Source - Register', e.toString());
      return {"success": false};
    }
  }

  static Future<Map> login(String username, String password) async {
    String url = '${Api.users}/login.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'username': username,
        'password': password,
      });
      DMethod.printTitle('User Source - Login', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      DMethod.printTitle('User Source - Login', e.toString());
      return {"success": false};
    }
  }

  static Future<bool> updateImage(
      String id, String oldImage, String newImage, String newBase64code) async {
    String url = '${Api.users}/update_image.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'old_image': oldImage,
        'new_image': newImage,
        'new_base64code': newBase64code,
      });
      DMethod.printTitle('User Source - Update Image', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('User Source - Update Image', e.toString());
      return false;
    }
  }

  static Future<Map<String, dynamic>> stat(String idUser) async {
    String url = '${Api.users}/stat.php';
    try {
      Response response =
          await Client().post(Uri.parse(url), body: {'id_user': idUser});
      DMethod.printTitle('User Source - Stat', response.body);
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      DMethod.printTitle('User Source - Stat', e.toString());
      return {
        'topic': 0.0,
        'follower': 0.0,
        'following': 0.0,
      };
    }
  }

  static Future<List<Users>> search(String query) async {
    String url = '${Api.users}/search.php';
    try {
      Response response =
          await Client().post(Uri.parse(url), body: {'search_query': query});
      DMethod.printTitle('User Source - Search', response.body);
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
      DMethod.printTitle('User Source - Search', e.toString());
      return [];
    }
  }
}
