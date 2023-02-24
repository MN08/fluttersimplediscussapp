import 'package:discuss_app/config/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/api.dart';
import '../models/users.dart';

class ItemUser extends StatelessWidget {
  const ItemUser({super.key, required this.user});
  final Users user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(AppRoute.profile, extra: user);
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          '${Api.imageUser}/${user.image}',
        ),
        radius: 18,
      ),
      title: Text(
        user.username,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
      trailing: const Icon(Icons.navigate_next),
    );
  }
}
