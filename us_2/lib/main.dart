import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:us_2/src/app.dart';
import 'package:us_2/src/srceen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
