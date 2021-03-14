import 'package:scan4u/models/user.dart';
import 'package:scan4u/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:scan4u/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //authenticate widger
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
