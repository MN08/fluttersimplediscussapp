import 'package:discuss_app/config/route.dart';
import 'package:discuss_app/controller/c_home.dart';
import 'package:discuss_app/pages/fragments/my_topic_fragment.dart';
import 'package:discuss_app/pages/fragments/profile_fragment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'fragments/explore_fragment.dart';
import 'fragments/feed_fragment.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List menu = [
      {
        'icon': Icons.feed,
        'label': 'Feed',
        'view': const FeedFragment(),
      },
      {
        'icon': Icons.explore,
        'label': 'Explore',
        'view': const ExploreFragment(),
      },
      {
        'icon': Icons.library_books,
        'label': 'My Topic',
        'view': const MyTopicFragment(),
      },
      {
        'icon': Icons.account_circle,
        'label': 'Profile',
        'view': const ProfileFragment(),
      }
    ];

    return Consumer<CHome>(builder: (context, _, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: menu[_.indexMenu]['view'],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(AppRoute.addTopic);
          },
          mini: true,
          tooltip: 'Create New Topic',
          child: const Icon(Icons.create),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _.indexMenu,
          onTap: (newIndex) {
            _.indexMenu = newIndex;
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: menu.map((e) {
            return BottomNavigationBarItem(
                icon: Icon(e['icon']), label: e['label']);
          }).toList(),
        ),
      );
    });
  }
}
