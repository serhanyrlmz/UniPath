import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'HomePage.dart';
import 'notificationPage.dart';
import 'search.dart';
import 'add.dart';
import 'settings.dart';
import 'announcements.dart';
import 'Profile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class Setting extends StatefulWidget {


  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int _selectedIndex=0;

  void _onItemTapped(int index){
    setState((){
      _selectedIndex=index;
      if(_selectedIndex==0) {
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return HomeScreen();
        }));}
      else if(_selectedIndex ==1){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return Search();
        }));
      }
      else if(_selectedIndex ==2){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return notificationPage();
        }));
      }
      else if(_selectedIndex ==3){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return Add();
        }));
      }
      else if(_selectedIndex ==4) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return Setting();
        }));
      }
      else if(_selectedIndex ==5) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return Profile();
        }));
      }

    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title:Text('Settings'),
        backgroundColor: AppColors.headingColor,
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.people))
        ],
      ),
      body:Center(
        child: Text('Settings'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.loginBackBottom,
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label:'home' ,backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.announcement),label:'home' ,backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label:'home' ,backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'home', backgroundColor: AppColors.loginBackBottom),

        ],
        type: BottomNavigationBarType.shifting,
        currentIndex:_selectedIndex,
        iconSize:40,
        onTap:_onItemTapped,

      ),

    );;
  }
}

