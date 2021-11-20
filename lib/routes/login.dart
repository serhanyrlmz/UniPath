
import 'package:UniPath/utils/color.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';


class Login extends StatelessWidget {

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
              SizedBox(height:40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,8,0,24),
                    child:Image.asset('assets/logo.png',
                      width: MediaQuery.of(context).size.width/4.5,),
                  ),
                ],
              ),

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
                  style: ButtonStyle(overlayColor: MaterialStateProperty.resolveWith(getColor),),
                  onPressed: () {Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

                      return HomeScreen();
                    }));
                    },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


