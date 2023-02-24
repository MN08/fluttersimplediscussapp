import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:discuss_app/models/topics.dart';
import 'package:http/http.dart';

import '../config/api.dart';

class TopicSource {
  static Future<bool> create(String title, String description, String images,
      String base64codes, String idUser) async {
    String url = '${Api.topics}/create.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'title': title,
        'description': description,
        'images': images,
        'base64codes': base64codes,
        'id_user': idUser,
      });
      DMethod.printTitle('Topic Source - Create Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - Create Topic', e.toString());
      return false;
    }
  }

  static Future<bool> update(
      String title, String description, String id) async {
    String url = '${Api.topics}/update.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'title': title,
        'description': description,
      });
      DMethod.printTitle('Topic Source - Update Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - Update Topic', e.toString());
      return false;
    }
  }

  static Future<bool> delete(String images, String id) async {
    String url = '${Api.topics}/delete.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'images': images,
      });
      DMethod.printTitle('Topic Source - Delete Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - Delete Topic', e.toString());
      return false;
    }
  }

  static Future<List<Topics>> getAllTopic() async {
    String url = '${Api.topics}/get_all_topic.php';
    try {
      Response response = await Client().get(Uri.parse(url));
      DMethod.printTitle('Topic Source - Get All Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topics.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - Get All Topic', e.toString());
      return [];
    }
  }

  static Future<List<Topics>> getAllTopicByFollowing(String userId) async {
    String url = '${Api.topics}/get_all_topics_by_following.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': userId,
      });
      DMethod.printTitle(
          'Topic Source - Get All Topic By Following', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topics.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle(
          'Topic Source - Get All Topic By Following', e.toString());
      return [];
    }
  }

  static Future<List<Topics>> getAllTopicByUserId(String userId) async {
    String url = '${Api.topics}/get_topic_by_user.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': userId,
      });
      DMethod.printTitle(
          'Topic Source - Get All Topic By User Id', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topics.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle(
          'Topic Source - Get All Topic By User Id', e.toString());
      return [];
    }
  }

  static Future<List<Topics>> search(String query) async {
    String url = '${Api.topics}/search.php';
    try {
      Response response =
          await Client().post(Uri.parse(url), body: {'search_query': query});
      DMethod.printTitle('Topic Source - Search', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topics.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - Search', e.toString());
      return [];
    }
  }
}
