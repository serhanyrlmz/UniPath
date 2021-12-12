import 'package:UniPath/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


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
      body: SingleChildScrollView(
        child: Container(
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
                  Spacer(flex:9),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CircleAvatar(
                        radius: 125,
                        child: ClipOval(
                          child:Image.asset('assets/logo.jpeg',
                            width: MediaQuery.of(context).size.width)
                        )
                      )
                    ),
                  ],
                ),

                Spacer(flex:5),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,22,10),
                  child:
                  TextFormField(
                    decoration: const InputDecoration(
                      fillColor: AppColors.TextFormBg,
                      filled: true,
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(320)),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22,10,22,0),
                  child:
                  TextFormField(
                    decoration: const InputDecoration(
                      fillColor: AppColors.TextFormBg,
                      filled: true,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.vpn_key_outlined),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.TextFormBg,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot_pass');},
                    child:
                      Text("Forgot password?",),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0,10,0,0),
                  child: ElevatedButton(
                    child: Text("Login", style: TextStyle(fontSize: 20.0),),
                    //color: Colors.red,
                    onPressed: () {
                      Navigator.pushNamed(context, '/HomePage');},
                  ),
                ),
                Spacer(flex:10),
                TextButton(
                  child: Text("Don't have an account? Sign Up!", style: TextStyle(fontSize:20.0),),
                  style: ButtonStyle(overlayColor:
                  MaterialStateProperty.resolveWith(getColor),),
                  onPressed: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
