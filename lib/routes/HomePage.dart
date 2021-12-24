import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'search.dart';
import 'announcements.dart';
import 'add.dart';
import 'settings.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

          return Settings();
        }));
      }

    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title:Text('Home Page'),
        backgroundColor: AppColors.headingColor,
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.people))
        ],

        ),


      body:Column(
        children: <Widget> [
          Card(
            child: Container(
              height:350.0,
              color:AppColors.headingColor,
              child:Column(
                children: <Widget>[
                  ListTile(
                    leading:CircleAvatar(),
                    title: Text("UniPath First Post")
                  ),
                  Expanded(
                    child:Container(
                      color:Colors.white,
                    ),
                  ),
                  
                  SizedBox(height:14.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:<Widget>[
                      Row(
                        children :<Widget>[
                          Icon(Icons.thumb_up),
                          Text("Like"),
                        ],
                      ),
                      Row(
                          children :<Widget>[
                            Icon(Icons.comment),
                            Text("Comments"),
                          ],
                      ),
                    ],
                  ),
                  SizedBox(height:12.0),
                ]
              )
            ),
          )
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.announcement),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label:'home' ,backgroundColor: AppColors.loginBackBottom),
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