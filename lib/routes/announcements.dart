import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'HomePage.dart';
import 'search.dart';
import 'add.dart';
import 'settings.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Announcements extends StatefulWidget {

  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
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

          return Announcements();
        }));
      }
      else if(_selectedIndex ==3){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return Add();
        }));
      }
      else if(_selectedIndex ==4){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return Setting();
        }));
      }

    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Announcements'),
        backgroundColor: AppColors.headingColor,
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.people))
        ],
      ),
      body: Center(

        child:Text('Announcements'),
      ),
        bottomNavigationBar: BottomNavigationBar(

          items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),
           BottomNavigationBarItem(icon: Icon(Icons.announcement),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),

         ],
           type: BottomNavigationBarType.shifting,
            currentIndex:_selectedIndex,
            iconSize:40,
              onTap:_onItemTapped,

           ),

     );
  }
}
