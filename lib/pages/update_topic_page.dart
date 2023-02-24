import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_mytopic.dart';
import 'package:discuss_app/models/topics.dart';
import 'package:discuss_app/sources/topic_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UpdateTopicPage extends StatefulWidget {
  const UpdateTopicPage({super.key, required this.topic});
  final Topics topic;

  @override
  State<UpdateTopicPage> createState() => _UpdateTopicPageState();
}

class _UpdateTopicPageState extends State<UpdateTopicPage> {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();

  updateTopic() {
    TopicSource.update(
            controllerTitle.text, controllerDescription.text, widget.topic.id)
        .then((success) {
      if (success) {
        context.read<CMyTopic>().setTopics(widget.topic.idUser);
        DInfo.snackBarSuccess(context, 'Update Topic Success');
        context.pop();
      } else {
        DInfo.snackBarError(context, 'Update Topic Failed');
      }
    });
  }

  @override
  void initState() {
    controllerTitle.text = widget.topic.title;
    controllerDescription.text = widget.topic.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Update Topic'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () => updateTopic(),
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Update Topic',
                style: TextStyle(color: Colors.white),
              ),
              DView.spaceWidth(5),
              const Icon(
                Icons.update,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DInput(
            controller: controllerTitle,
            title: 'Title',
          ),
          DView.spaceHeight(20),
          DInput(
            controller: controllerDescription,
            title: 'Description',
          ),
        ],
      ),
    );
  }
}
