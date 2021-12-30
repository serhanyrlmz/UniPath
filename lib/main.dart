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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:UniPath/routes/notificationPage.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print('Cannot connect to firebase: '+snapshot.error.toString());
            return MaterialApp(
              home: Welcome(analytics: analytics, observer: observer),
            );
          }
          if(snapshot.connectionState == ConnectionState.done) {
            FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
            print('Firebase connected');
            return AppBase();
          }

          return MaterialApp(
            home: Welcome(analytics: analytics, observer: observer),
          );
        }
    );
  }
}

class AppBase extends StatelessWidget {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      home: WalkThrough(analytics: analytics, observer: observer),
      routes: {
          '/welcome': (context) => Welcome(analytics: analytics, observer: observer),
          '/walkthrough': (context) => WalkThrough(analytics: analytics, observer: observer),
          '/login': (context) => Login(analytics: analytics, observer: observer),
          '/signup': (context) => SignUp(analytics: analytics, observer: observer),
          '/search' : (context) => Search(),
          '/settings' : (context) => Setting(),
          '/HomePage' : (context) => HomeScreen(),

        },
    );
  }
}
