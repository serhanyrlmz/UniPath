import 'package:UniPath/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


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
              SizedBox(height:55),

              IconButton(
                icon: Icon(Icons.add_a_photo_rounded),
                iconSize:100,
                color:Colors.white,
                onPressed:(){
                  //add the choosing photo function here.
                }
              ),

              SizedBox(height:25),

              Padding(
                padding: const EdgeInsets.fromLTRB(22,10,22,10),
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
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),

              ElevatedButton(
                child: Text("Sign Up", style: TextStyle(fontSize:20.0),),
                style: ButtonStyle(overlayColor:
                  MaterialStateProperty.resolveWith(getColor),),
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                  },
              ),

              Spacer(),

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



