import 'package:flutter/foundation.dart';

import '../sources/follow_source.dart';
import '../models/users.dart';

class CFollowing extends ChangeNotifier {
  List<Users> _following = [];
  List<Users> get following => _following;
  setFollowing(String idUser) async {
    _following = await FollowSource.showFollowing(idUser);
    notifyListeners();
  }
}
