import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/route.dart';
import 'package:discuss_app/controller/c_mytopic.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/models/topics.dart';
import 'package:discuss_app/sources/topic_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyTopicFragment extends StatelessWidget {
  const MyTopicFragment({super.key});

  deleteTopic(BuildContext context, Topics topic) {
    TopicSource.delete(topic.images, topic.id).then((success) {
      if (success) {
        context.read<CMyTopic>().setTopics(topic.idUser);
        DInfo.snackBarSuccess(context, 'Delete Topic Success');
      } else {
        DInfo.snackBarError(context, 'Delete Topic Failed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<CUser>().data;
    context.read<CMyTopic>().setTopics(user!.id);
    return Column(
      children: [
        DView.spaceHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DView.textTitle('My Topics', size: 24),
        ),
        DView.spaceHeight(20),
        Expanded(
          child: Consumer<CMyTopic>(
            builder: (contextConsumer, _, child) {
              if (_.topics.isEmpty) return DView.empty();
              return ListView.builder(
                padding: const EdgeInsets.all(1),
                itemCount: _.topics.length,
                itemBuilder: (context, index) {
                  Topics topic = _.topics[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text('${index + 1}'),
                    ),
                    horizontalTitleGap: 5,
                    title: Text(
                      topic.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      topic.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'Detail') {
                          context.push(AppRoute.detailTopic,
                              extra: topic..users = user);
                        }
                        if (value == 'Update') {
                          context.push(AppRoute.updateTopic,
                              extra: topic..users = user);
                        }
                        if (value == 'Delete') {
                          deleteTopic(context, topic);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "Detail",
                          child: Text('Detail'),
                        ),
                        const PopupMenuItem(
                          value: "Update",
                          child: Text('Update'),
                        ),
                        const PopupMenuItem(
                          value: "Delete",
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
