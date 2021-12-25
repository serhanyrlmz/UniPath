
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'HomePage.dart';
import 'search.dart';
import 'add.dart';
import 'settings.dart';
import 'announcements.dart';
import 'package:UniPath/routes/storage_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
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
   final Storage storage= Storage();
    return Scaffold(

      appBar: AppBar( title:Text('Add'),
        backgroundColor: AppColors.headingColor,
      ),
      body:Column(
        children: [
          Center(
            child:ElevatedButton(
                onPressed: () async {
                  final results=await FilePicker.platform.pickFiles(
                    allowMultiple:false,
                    type:FileType.custom,
                    allowedExtensions: ['png','jpg'],
                  );
                  if(results==null){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No files selected')
                        ),
                    );
                    return null;
                  }
                  final path= results.files.single.path;
                  final fileName=results.files.single.name;

                  storage.uploadFile(path,fileName)
                      .then((value)=>print('Done'));



                },
                child:Text('Upload File')
            )
          )
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label:'home',backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.announcement),label:'home',backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label:'home',backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label:'home',backgroundColor: AppColors.loginBackBottom),

        ],
        type: BottomNavigationBarType.shifting,
        currentIndex:_selectedIndex,
        iconSize:40,
        onTap:_onItemTapped,

      ),

    );
  }
}

