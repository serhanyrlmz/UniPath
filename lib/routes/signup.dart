import 'package:UniPath/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:UniPath/utils/analytics.dart';
import 'package:UniPath/utils/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  late String email, username, pass,name;
  final _auth = FirebaseAuth.instance;

  Future<void> userSetup({required String name, required String username,required String email}) async {
    //firebase auth instance to get uuid of user
    User? auth = FirebaseAuth.instance.currentUser;

    //now below I am getting an instance of firebaseiestore then getting the user collection
    //now I am creating the document if not already exist and setting the data.
    FirebaseFirestore.instance.collection('users').doc(auth!.uid).set(
        {
          'email':email,'username':username,'name': name, 'uid': auth.uid
        });

    return;
  }

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
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    email = value;
                  },
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22,10,22,10),
                child:
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: AppColors.TextFormBg,
                    filled: true,
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.supervised_user_circle),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(320)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (String value) {
                    username = value;
                  },
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22,10,22,10),
                child:
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: AppColors.TextFormBg,
                    filled: true,
                    hintText: 'Your Name',
                    prefixIcon: Icon(Icons.supervised_user_circle),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(320)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (String value) {
                    name = value;
                  },
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22,10,22,12),
                child:
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: AppColors.TextFormBg,
                    filled: true,
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.vpn_key_outlined),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(320)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (String value) {
                    pass = value;
                  },
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),

              ElevatedButton(
                child: Text("Sign Up", style: TextStyle(fontSize:20.0),),
                style: ButtonStyle(overlayColor:
                  MaterialStateProperty.resolveWith(getColor),),
                onPressed: () async {


                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: pass);
                    if (newUser != null) {
                      userSetup(name:name,username:username,email:email);
                      Navigator.pushNamed(context, '/login');
                    }
                  } catch (e) {
                    print(e);
                  }
                  },
              ),

              Spacer(flex:10),

              TextButton(
                child: Text("Already have an account? Login!", style: TextStyle(fontSize:20.0),),
                style: ButtonStyle(overlayColor:
                  MaterialStateProperty.resolveWith(getColor),),
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
              )
            ]
          )
        )
      ),
    );
  }
}

