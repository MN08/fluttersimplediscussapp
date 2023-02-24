import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../sources/user_source.dart';
import '../config/route.dart';
import '../config/session.dart';
import '../controller/c_user.dart';
import '../models/users.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) {
    UserSource.login(controllerUsername.text, controllerPassword.text)
        .then((responseBody) {
      if (responseBody['success']) {
        var mapUser = Map<String, dynamic>.from(responseBody['data']);
        Users users = Users.fromJson(mapUser);
        Session.setUser(users);
        context.read<CUser>().data = users;

        DInfo.dialogSuccess(context, 'Login Success');
        DInfo.closeDialog(context, actionAfterClose: () {
          context.go(AppRoute.home);
        });
      } else {
        DInfo.snackBarError(context, 'Login Failed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green.shade400, Colors.yellow.shade400]),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          DView.textTitle('Login'),
                          DView.spaceHeight(8),
                          const Divider(),
                          DView.spaceHeight(4),
                          DInput(
                            controller: controllerUsername,
                            title: 'Username',
                            spaceTitle: 4,
                          ),
                          DView.spaceHeight(),
                          DInputPassword(
                            controller: controllerPassword,
                            title: 'Password',
                            spaceTitle: 4,
                          ),
                          DView.spaceHeight(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => login(context),
                              child: const Text('Login'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya Akun ?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(AppRoute.register);
                          },
                          child: const Text('Register'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
