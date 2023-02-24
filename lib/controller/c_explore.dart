import 'package:flutter/foundation.dart';

import '../models/topics.dart';
import '../sources/topic_source.dart';

class CExplore extends ChangeNotifier {
  List<Topics> _topics = [];
  List<Topics> get topics => _topics;
  setTopics() async {
    _topics = await TopicSource.getAllTopic();
    notifyListeners();
  }
}
