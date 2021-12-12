import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'package:UniPath/routes/search.dart';
import 'package:UniPath/routes/announcements.dart';
import 'package:UniPath/routes/add.dart';
import 'package:UniPath/routes/settings.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomePage> {
  String _message = "";

  void setMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'CS310_Test', parameters: <String, dynamic>{
      "string": "myString",
      "int": 12,
    });
    setMessage("setLogEvent succeeded.");
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: "Home View",
      screenClassOverride: "HomeView",
    );
    setMessage("setCurrentScreen is succeeded.");
  }

  Future<void> _setUserId() async {
    await widget.analytics.setUserId("cs310step4");
    setMessage("setUserId is succeeded.");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title:Text('Home Page'),
        backgroundColor: AppColors.headingColor,
      ),
      body:Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.announcement),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label:'home' ,backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),

        ],
      ),

    );
  }
}
