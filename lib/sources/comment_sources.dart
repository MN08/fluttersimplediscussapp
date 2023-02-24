import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../models/comments.dart';
import '../config/api.dart';

class CommentSource {
  static Future<bool> create(
    String idTopic,
    String fromIdUser,
    String toIdUser,
    String description,
    String image,
    String base64codes,
  ) async {
    String url = '${Api.comments}/create.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_topic': idTopic,
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
        'description': description,
        'image': image,
        'base64codes': base64codes,
      });
      DMethod.printTitle('Comments Source - Create Comments', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Comments Source - Create Comments', e.toString());
      return false;
    }
  }

  static Future<bool> delete(
    String id,
    String image,
  ) async {
    String url = '${Api.comments}/delete.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'image': image,
      });
      DMethod.printTitle('Comments Source - Delete Comments', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Comments Source - Delete Comments', e.toString());
      return false;
    }
  }

  static Future<List<Comments>> getAllComment(String idTopic) async {
    String url = '${Api.comments}/get_all_comment.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_topic': idTopic,
      });
      DMethod.printTitle('Comments Source - Get All Comments', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Comments.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Comments Source - Get All Comments', e.toString());
      return [];
    }
  }
}
