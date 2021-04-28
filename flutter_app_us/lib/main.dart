import 'package:flutter/material.dart';
import 'package:flutter_app_us/data/join_or_login.dart';
import 'package:flutter_app_us/screens/login.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<JoinOrLogin>.value(
          value:JoinOrLogin(),
          child: AuthPage()),
    );

  }
}

