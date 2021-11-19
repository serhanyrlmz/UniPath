import 'package:flutter/material.dart';
import 'package:UniPath/routes/welcome.dart';
import 'package:UniPath/routes/login.dart';
import 'package:UniPath/routes/signup.dart';


void main() => runApp(MaterialApp(
  //home: Welcome(),
  //initialRoute: '/login',
  routes: {
    '/': (context) => Welcome(),
    '/login': (context) => Login(),
    '/signup': (context) => SignUp(),
  },
));
