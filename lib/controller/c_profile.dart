import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';

import '../sources/follow_source.dart';
import '../sources/topic_source.dart';
import '../sources/user_source.dart';

import '../models/topics.dart';

class CProfile extends ChangeNotifier {
  List<Topics> _topics = [];
  List<Topics> get topics => _topics;
  setTopics(String idUser) async {
    _topics = await TopicSource.getAllTopicByUserId(idUser);
    notifyListeners();
  }

  Map<String, dynamic> _stat = {
    'topic': 0.0,
    'following': 0.0,
    'follower': 0.0,
  };
  Map<String, dynamic> get stat => _stat;
  setStat(String idUser) async {
    _stat = await UserSource.stat(idUser);
    notifyListeners();
  }

  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;
  checkIsFollowing(String fromIdUser, String toIdUser) async {
    _isFollowing = await FollowSource.checkIsFollowing(fromIdUser, toIdUser);
    notifyListeners();
  }

  setFollow(
    BuildContext context,
    String fromIdUser,
    String toIdUser,
  ) {
    if (isFollowing) {
      FollowSource.unfollow(fromIdUser, toIdUser).then((success) {
        if (success) {
          setStat(toIdUser);
          checkIsFollowing(fromIdUser, toIdUser);
          DInfo.snackBarSuccess(context, "success to Unfollow");
        } else {
          DInfo.snackBarError(context, "failed to Unfollow");
        }
      });
    } else {
      FollowSource.following(fromIdUser, toIdUser).then((success) {
        if (success) {
          setStat(toIdUser);
          checkIsFollowing(fromIdUser, toIdUser);
          DInfo.snackBarSuccess(context, "success to Follow");
        } else {
          DInfo.snackBarError(context, "failed to Follow");
        }
      });
    }
  }
}
