


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'package:image_picker/image_picker.dart';
import 'HomePage.dart';
import 'notificationPage.dart';
import 'search.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:UniPath/routes/settings.dart';
import 'announcements.dart';
import 'package:UniPath/routes/storage_service.dart';
import 'package:path/path.dart' as path;

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> postSetup({required String postPostUrl}) async {
    //firebase auth instance to get uuid of user
    User? auth = FirebaseAuth.instance.currentUser;

    //now below I am getting an instance of firebaseiestore then getting the user collection
    //now I am creating the document if not already exist and setting the data.
    FirebaseFirestore.instance.collection('users').doc(auth!.uid).set(
        {
          'posts':postPostUrl,
        });

    return;
  }
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path) ;
      postSetup(postPostUrl:storage.ref(fileName).putFile(imageFile) as String);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            );

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
  }
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
   final Storage storage= Storage();
    return Scaffold(

      appBar: AppBar( title:Text('Add'),
        backgroundColor: AppColors.headingColor,
      ),

       body: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(
           children: [
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             ElevatedButton.icon(
                 onPressed: () => _upload('camera'),
                 icon: Icon(Icons.camera),
                 label: Text('camera')),
             ElevatedButton.icon(
                 onPressed: () => _upload('gallery'),
                 icon: Icon(Icons.library_add),
                 label: Text('Gallery')),
           ],
         ),
         ],
       ),

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

