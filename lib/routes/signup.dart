import 'package:UniPath/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGNUP',
          style: kAppBarTitleTextStyle,
        ),
        //backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
    );
  }
}
