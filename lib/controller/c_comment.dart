import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../sources/comment_sources.dart';
import '../models/users.dart';
import '../models/topics.dart';
import '../models/comments.dart';

class CComment extends ChangeNotifier {
  List<Comments> _comments = [];
  List<Comments> get comments => _comments;
  setComments(Topics topics) async {
    _image = '';
    _imageBase64Code = '';
    _comments = await CommentSource.getAllComment(topics.id);
    setReplyTo(topics.users!);
    notifyListeners();
  }

  Users? _replyTo;
  Users? get replyTo => _replyTo;
  setReplyTo(Users users) {
    _replyTo = users;
    notifyListeners();
  }

  String _image = '';
  String get image => _image;

  String _imageBase64Code = '';
  String get imageBase64Code => _imageBase64Code;

  pickImage(ImageSource source) async {
    XFile? imagePick = await ImagePicker().pickImage(source: source);
    if (imagePick != null) {
      _image = imagePick.name;
      _imageBase64Code = base64Encode(await imagePick.readAsBytes());
      notifyListeners();
    }
  }
}
