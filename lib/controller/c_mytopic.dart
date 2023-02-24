import 'package:flutter/foundation.dart';

import '../models/topics.dart';
import '../sources/topic_source.dart';

class CMyTopic extends ChangeNotifier {
  List<Topics> _topics = [];
  List<Topics> get topics => _topics;
  setTopics(String idUser) async {
    _topics = await TopicSource.getAllTopicByUserId(idUser);
    notifyListeners();
  }
}
