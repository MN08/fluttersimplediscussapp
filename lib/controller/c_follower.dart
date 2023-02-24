import 'package:flutter/foundation.dart';

import '../sources/follow_source.dart';
import '../models/users.dart';

class CFollower extends ChangeNotifier {
  List<Users> _follower = [];
  List<Users> get follower => _follower;
  setFollower(String idUser) async {
    _follower = await FollowSource.showFollower(idUser);
    notifyListeners();
  }
}
