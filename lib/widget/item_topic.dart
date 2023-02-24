import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/api.dart';
import '../config/app_color.dart';
import '../config/app_format.dart';
import '../config/route.dart';
import '../models/topics.dart';

class ItemTopic extends StatelessWidget {
  const ItemTopic({super.key, required this.topic, required this.images});
  final Topics topic;
  final List images;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(AppRoute.profile, extra: topic.users);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      '${Api.imageUser}/${topic.users!.image}',
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                DView.spaceWidth(7),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'by ',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                        children: [
                          TextSpan(
                            text: topic.users!.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
                GestureDetector(
                  onTap: () {
                    context.push(AppRoute.detailTopic, extra: topic);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: const EdgeInsets.fromLTRB(12, 6, 8, 6),
                    child: DView.textAction(
                      () {
                        context.push(AppRoute.detailTopic, extra: topic);
                      },
                      text: 'Detail',
                      size: 14,
                      color: Theme.of(context).primaryColor,
                      iconRight: Icons.navigate_next,
                      iconRightSize: 17,
                      iconRightColor: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
            DView.spaceHeight(12),
            Text(
              topic.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            DView.spaceHeight(12),
            if (images.isNotEmpty)
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            '${Api.imageTopic}/${images[0]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    if (images.length > 1)
                      Container(
                        width: 60,
                        height: double.infinity,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade400,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '+${images.length - 1}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            DView.spaceHeight(7),
            Text(
              AppFormat.publishDate(topic.createdAt),
            ),
          ],
        ),
      ),
    );
  }
}
