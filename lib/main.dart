import 'package:UniPath/routes/HomePage.dart';
import 'package:UniPath/routes/add.dart';
import 'package:UniPath/routes/announcements.dart';
import 'package:UniPath/routes/search.dart';
import 'package:UniPath/routes/settings.dart';
import 'package:UniPath/routes/walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/routes/welcome.dart';
import 'package:UniPath/routes/login.dart';
import 'package:UniPath/routes/signup.dart';
    //gbcf

void main() => runApp(MaterialApp(
  //home: Welcome(),
  //initialRoute: '/login',
  routes: {
    '/': (context) => WalkThrough(),
    '/add':(context)=> Add(),
    '/announcements': (context)=> Announcements(),
    //'/forgot_pass':(context)=> forgot_pass(),
    '/HomePage':(context)=> HomeScreen(),
    '/login': (context) => Login(),
    '/search':(context)=> SearchScreen(),
    '/settings':(context)=> Settings(),
    '/signup': (context) => SignUp(),
//    'walkthrough':(context)=>
    '/welcome':(context)=> Welcome(),



  },
));

