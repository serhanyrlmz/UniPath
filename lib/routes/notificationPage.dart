import 'package:UniPath/models/notification.dart';
import 'package:UniPath/models/notificationCart.dart';
import 'package:UniPath/routes/search.dart';
import 'package:UniPath/routes/settings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:UniPath/utils/color.dart';

import 'HomePage.dart';
import 'add.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({Key? key}) : super(key: key);

  @override
  _notificationPageState createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {

  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "", photoUrl = "", notifType = "", uid = "";

  final List<Notif> notifications = [
  Notif(notifType: 'like',
      userPhotoURL: 'https://i4.hurimg.com/i/hurriyet/75/770x0/5f007af7d3806c129c7039f3.jpg',
      username: 'The_Beatles',
      postPhotoURL:'https://img-s1.onedio.com/id-55257c07af6b6a0336c2d89f/rev-0/raw/s-ffec9def22fc6d078df21304f9764051c267176a.jpg'),
  Notif(notifType: 'like',
      userPhotoURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGfFrulUDv_-DCKCK9BGNbt-30ySoaiYiuUw&usqp=CAU',
      username: 'MeTalliCa',
      postPhotoURL:'https://img-s1.onedio.com/id-55257c07af6b6a0336c2d89f/rev-0/raw/s-ffec9def22fc6d078df21304f9764051c267176a.jpg'),
  Notif(notifType: 'comment',
      userPhotoURL: 'https://i.scdn.co/image/2f123bb26564d8a4cc63bc396a094cc4a74dc782',
      username: '_scorpions_',
      postPhotoURL:'https://img-s1.onedio.com/id-55257c07af6b6a0336c2d89f/rev-0/raw/s-ffec9def22fc6d078df21304f9764051c267176a.jpg'),
  Notif(notifType: 'followRequest',
      userPhotoURL: 'https://upload.wikimedia.org/wikipedia/tr/a/ac/Acdc_Highway_to_Hell.JPG',
      username: 'ACDC_official',
      postPhotoURL:'https://img-s1.onedio.com/id-55257c07af6b6a0336c2d89f/rev-0/raw/s-ffec9def22fc6d078df21304f9764051c267176a.jpg'),
  Notif(notifType: 'follow',
      userPhotoURL: 'https://365psd.com/images/previews/b9d/kiss-band-42327.jpg',
      username: 'The_Kiss_Band',
      postPhotoURL:'https://img-s1.onedio.com/id-55257c07af6b6a0336c2d89f/rev-0/raw/s-ffec9def22fc6d078df21304f9764051c267176a.jpg'),
  Notif(notifType: 'like',
      userPhotoURL: 'https://img.discogs.com/4m4PENK2GrF7NgJxkSEuvPcnAsg=/fit-in/588x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-3284621-1323933038.jpeg.jpg',
      username: 'W.A.S.P',
      postPhotoURL:'https://img-s1.onedio.com/id-55257c07af6b6a0336c2d89f/rev-0/raw/s-ffec9def22fc6d078df21304f9764051c267176a.jpg'),
  ];
  /*void _loadUserFeed() async {
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _user.uid)
        .get();

    username = x.docs[0]['username'];
    fullname = x.docs[0]['fullname'];
    followers = x.docs[0]['followers'];
    following = x.docs[0]['following'];
    phoneNumber = x.docs[0]['phoneNumber'];
    photoUrl = x.docs[0]['photoUrl'];
    description = x.docs[0]['description'];
    profType = x.docs[0]['profType'];
    uid = x.docs[0]['uid'];
    activation = x.docs[0]['activation'];

    var notifs = await FirebaseFirestore.instance
        .collection('notifications')
        .where('uid', isEqualTo: uid)
        .get();
    var notifs_opp = await FirebaseFirestore.instance
        .collection('notifications')
        .where('otherUid', isEqualTo: uid)
        .get();

    notifs.docs.forEach((doc) => {
      if (doc['notifType'] == "like") {
        notifications.add(
            Notif(
              pid: doc['pid'],
              username: doc['username'],
              uid: doc['uid'],
              userPhotoURL: doc['userPhotoURL'],
              postPhotoURL: doc['postPhotoURL'],
              notifType: doc['notifType'],
              otherUid: doc['otherUid'],
              notifID: doc['notifID'],
            )
        )
      }
    });

    notifs_opp.docs.forEach((doc) => {
      if (doc['notifType'] == "follow" || doc['notifType'] == "followRequest") {
        notifications.add(
            Notif(
              pid: doc['pid'],
              username: doc['username'],
              uid: doc['uid'],
              userPhotoURL: doc['userPhotoURL'],
              postPhotoURL: doc['postPhotoURL'],
              notifType: doc['notifType'],
              otherUid: doc['otherUid'],
              notifID: doc['notifID'],
            )
        )
      }
    });

    //notifications..sort((a,b) => b.date.compareTo(a.date));
    setState(() {
      notifLoading = false;
    });

  }

  loadingScreen(context) {
    return [
      Padding(
        padding: const EdgeInsets.only(top:100),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 75,
                      height: 75,
                      child: new CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
                "Your notifications are getting ready...",
                style: TextStyle(
                    color: AppColors.textColor,
                )
            )
          ],
        ),
      )

    ];
  }

  void initState() {
    super.initState();
    _loadUserFeed();
  }*/

  int _selectedIndex=0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
      else if (_selectedIndex == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return Search();
        }));
      }
      else if (_selectedIndex == 2) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return notificationPage();
        }));
      }
      else if (_selectedIndex == 3) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return Add();
        }));
      }
      else if (_selectedIndex == 4) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return Setting();
        }));
      }
    }
    );
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Notifications'),
          backgroundColor: AppColors.headingColor,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: notifications.length,
          itemBuilder: (BuildContext context, int index) {
            return notificationCart(notif: notifications[index]);
          },
          separatorBuilder: (BuildContext context,
              int index) => const Divider(),
        ),
        bottomNavigationBar: BottomNavigationBar(

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),
                label: 'home',
                backgroundColor: AppColors.loginBackBottom),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined),
                label: 'home',
                backgroundColor: AppColors.loginBackBottom),
            BottomNavigationBarItem(icon: Icon(Icons.announcement),
                label: 'home',
                backgroundColor: AppColors.loginBackBottom),
            BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),
                label: 'home',
                backgroundColor: AppColors.loginBackBottom),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),
                label: 'home',
                backgroundColor: AppColors.loginBackBottom),

          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          iconSize: 40,
          onTap: _onItemTapped,
        ),
      );
    }
  }