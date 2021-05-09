import 'package:flutter/material.dart';
import 'package:us_2/src/srceen/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ground Us',
      theme: ThemeData(
          accentColor: Colors.black,
          primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}