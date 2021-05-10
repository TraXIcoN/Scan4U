import 'dart:convert';

import 'package:scan4u/Model/documentModel.dart';
import 'package:scan4u/Providers/documentProvider.dart';
import 'package:scan4u/dashboard_screen.dart';
import 'package:scan4u/showImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scan4u/flutter_login.dart';
import 'user.dart';
import 'package:scan4u/Home.dart';
import 'constants.dart';
import 'coustom_route.dart';
import 'services/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DocumentProvider>(
        create: (context) => DocumentProvider(),
        child: MaterialApp(home: MyApp1()));
    /* return MaterialApp(home: MyApp1()); */
  }
}

class MyApp1 extends StatelessWidget {
  static const routeName = '/auth';

  var mockuser1 = mockUsers;

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> login(LoginData data) async {
    print('its in11');
    dynamic result =
        await _auth.signInWithEmailAndPassword(data.name, data.password);
    if (result == null) {
      print('Wrong Username!');
    }
    mockuser1[data.name] = data.password;
    print(mockuser1);
  }

  Future<String?> signup(LoginData data) async {
    dynamic result =
        await _auth.registerWithEmailAndPassword(data.name, data.password);
    if (result == null) {
      return 'Wrong Username!';
    } else {
      mockuser1[data.name] = data.password;
      return 'user added!';
    }
  }

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockuser1.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (mockuser1[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockuser1.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      logo: 'lib/Model/images/docIcon.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      emailValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return login(loginData);
      },
      onSignup: (loginData) {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return signup(loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => Home(),
        ));
      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
    );
  }
}
