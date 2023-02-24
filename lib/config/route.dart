import 'package:discuss_app/config/session.dart';
import 'package:discuss_app/controller/c_addtopic.dart';
import 'package:discuss_app/controller/c_comment.dart';
import 'package:discuss_app/controller/c_follower.dart';
import 'package:discuss_app/controller/c_following.dart';
import 'package:discuss_app/controller/c_profile.dart';
import 'package:discuss_app/controller/c_search.dart';
import 'package:discuss_app/models/topics.dart';
import 'package:discuss_app/models/users.dart';
import 'package:discuss_app/pages/add_topic.dart';
import 'package:discuss_app/pages/comment_page.dart';
import 'package:discuss_app/pages/detaill_topic_page.dart';
import 'package:discuss_app/pages/error_page.dart';
import 'package:discuss_app/pages/follower_page.dart';
import 'package:discuss_app/pages/following_page.dart';

import 'package:discuss_app/pages/home_page.dart';
import 'package:discuss_app/pages/login_page.dart';
import 'package:discuss_app/pages/profile_page.dart';
import 'package:discuss_app/pages/register_page.dart';
import 'package:discuss_app/pages/search_page.dart';
import 'package:discuss_app/pages/update_topic_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  //topic route
  static const addTopic = '/add-topic';
  static const detailTopic = '/detail-topic';
  static const updateTopic = '/update-topic';
  static const search = '/search';

  static const profile = '/profile';
  static const follower = '/follower';
  static const following = '/following';
  static const comment = '/comment';

  static GoRouter routerConfig = GoRouter(
      errorBuilder: (context, state) => ErrorPage(
            title: "Somthing Wrong",
            description: state.error.toString(),
          ),
      debugLogDiagnostics: true,
      redirect: (context, state) async {
        Users? user = await Session.getUser();
        if (user == null) {
          if (state.location == login || state.location == register) {
            return null;
          }
          return login;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: register,
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: addTopic,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CAddTopic(),
            child: AddTopic(),
          ),
        ),
        GoRoute(
          path: profile,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CProfile(),
            child: ProfilePage(user: state.extra as Users),
          ),
        ),
        GoRoute(
          path: search,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CSearch(),
            child: const SearchPage(),
          ),
        ),
        GoRoute(
          path: follower,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CFollower(),
            child: FollowerPage(user: state.extra as Users),
            // child: FollowerPage(user: state.extra as Users),
          ),
        ),
        GoRoute(
          path: following,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CFollowing(),
            child: FollowingPage(user: state.extra as Users),
            // child: FollowingPage(user: state.extra as Users),
          ),
        ),
        GoRoute(
          path: detailTopic,
          builder: (context, state) => DetailTopicPage(
            topic: state.extra as Topics,
          ),
        ),
        GoRoute(
          path: updateTopic,
          builder: (context, state) => UpdateTopicPage(
            topic: state.extra as Topics,
          ),
        ),
        GoRoute(
          path: comment,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CComment(),
            child: CommentPage(
              topics: state.extra as Topics,
            ),
            // child: CommentPage(topic: state.extra as Topics),
          ),
        ),
      ]);
}
