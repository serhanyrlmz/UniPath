import 'package:UniPath/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'package:UniPath/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:UniPath/utils/analytics.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{

        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      return Colors.black;
    }
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end :Alignment.bottomCenter,
              colors: [AppColors.loginBackTop, AppColors.loginBackBottom]
            ),
          ),
          child: Center(
            child:Column(
              children:[
                Spacer(flex:110),

                Text(
                    "Welcome to the UniPath",
                  textAlign: TextAlign.center,
                  style: WelcomeText,
                ),

                Spacer(flex:85),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child:Image.asset('assets/logo.jpeg',
                    width: MediaQuery.of(context).size.width/1.3,),
                ),

                Spacer(flex:90),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    ElevatedButton(
                      child: Text("Sign Up", style: TextStyle(fontSize:25.0),),
                      style: ButtonStyle(overlayColor:
                      MaterialStateProperty.resolveWith(getColor),),
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                    ),
                    SizedBox(width:35),
                    ElevatedButton(
                      child: Text("Login", style: TextStyle(fontSize:25.0),),
                      style: ButtonStyle(overlayColor:
                      MaterialStateProperty.resolveWith(getColor),),
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                    ),
                  ]
                ),
                Spacer(flex:100),
              ]
            )
          )
      ),
    );
  }
}
