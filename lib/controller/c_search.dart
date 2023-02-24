import 'package:flutter/foundation.dart';

import '../models/users.dart';
import '../models/topics.dart';
import '../sources/user_source.dart';
import '../sources/topic_source.dart';

class CSearch extends ChangeNotifier {
  List<String> get filters => ['Topics', 'Users'];

  String _filter = 'Topics';
  String get filter => _filter;
  set filter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  search(String query) {
    if (filter == 'Topics') {
      setTopics(query);
    } else {
      setUsers(query);
    }
  }

  List<Topics> _topics = [];
  List<Topics> get topics => _topics;
  setTopics(String query) async {
    _topics = await TopicSource.search(query);
    notifyListeners();
  }

  List<Users> _users = [];
  List<Users> get users => _users;
  setUsers(String query) async {
    _users = await UserSource.search(query);
    notifyListeners();
  }
}
