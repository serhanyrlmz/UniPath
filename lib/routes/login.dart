import 'package:UniPath/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';




class Login extends StatefulWidget {
  const Login({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email,pass;
  final _auth = FirebaseAuth.instance;

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
              child: Column(
                  children:[
                    Spacer(flex:5),

                    IconButton(
                      icon: Icon(Icons.add_a_photo_rounded),
                      iconSize:125,
                      color:Colors.white,
                      onPressed:(){
                        //add the choosing photo function here.
                      },
                    ),

                    Spacer(flex:3),

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
                        onChanged: (value) {
                        email = value;
                        //Do something with the user input.
                        },
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
                        onChanged: (value) {
                        pass = value;
                        //Do something with the user input.
                        },
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
                        onPressed: () async {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: pass);
                            if (user != null) {
                              Navigator.pushNamed(context, '/HomePage');

                            }
                          } catch (e) {
                            print(e);
                          }
                        }
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
                  ]
              )
          )
      ),
    );
  }
}

