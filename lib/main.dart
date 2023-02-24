import 'package:discuss_app/config/session.dart';
import 'package:discuss_app/controller/c_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:discuss_app/config/app_color.dart';
import 'package:discuss_app/config/route.dart';

import 'package:discuss_app/controller/c_explore.dart';
import 'package:discuss_app/controller/c_feed.dart';
import 'package:discuss_app/controller/c_home.dart';
import 'package:discuss_app/controller/c_mytopic.dart';
import 'package:discuss_app/controller/c_user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CUser()),
        ChangeNotifierProvider(create: (_) => CHome()),
        ChangeNotifierProvider(create: (_) => CFeed()),
        ChangeNotifierProvider(create: (_) => CExplore()),
        ChangeNotifierProvider(create: (_) => CMyTopic()),
        ChangeNotifierProvider(create: (_) => CAccount()),
      ],
      builder: (context, child) {
        Session.getUser().then((users) async {
          if (users != null) context.read<CUser>().data = users;
        });
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: AppColor.primary,
            colorScheme: const ColorScheme.light().copyWith(
                primary: AppColor.primary, secondary: AppColor.primary),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
            ),
          ),
          routerConfig: AppRoute.routerConfig,
        );
      },
    );
  }
}
