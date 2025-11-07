import 'package:flutter/material.dart';
//import 'package:taskfive/screens/login/login_screen.dart';
import 'package:taskfive/screens/splashScreen.dart';
import 'package:taskfive/theme.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SplashScreen(),
    ),
  );
}
