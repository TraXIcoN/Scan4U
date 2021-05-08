import 'dart:convert';

import 'package:documentscanner2/Model/documentModel.dart';
import 'package:documentscanner2/Providers/documentProvider.dart';
import 'package:documentscanner2/dashboard_screen.dart';
import 'package:documentscanner2/showImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:documentscanner2/flutter_login.dart';
import 'user.dart';
import 'Home.dart';
import 'coustom_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const routeName = '/auth';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      Home();
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: DocumentProvider(),
        child: MaterialApp(
          theme: ThemeData(
              appBarTheme: AppBarTheme(color: ThemeData.dark().canvasColor),
              textSelectionColor: Colors.blueGrey,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: ThemeData.dark().canvasColor)),
          home: FlutterLogin(
            logo: 'lib/Model/images/docIcon.png',
            title: 'ScaN4U',
            onLogin: (loginData) {
              print('Login info');
              print('Name: ${loginData.name}');
              print('Password: ${loginData.password}');
              return _loginUser(loginData);
            },
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(FadePageRoute(
                builder: (context) => DashboardScreen(),
              ));
            },
            onRecoverPassword: (String) {},
            onSignup: (LoginData) {},
            theme: LoginTheme(
              titleStyle: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'Quicksand',
                letterSpacing: 2,
              ),
            ),
          ),
        ));
  }
}
