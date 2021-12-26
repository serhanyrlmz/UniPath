import 'dart:io';
import 'package:UniPath/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/user.dart';
import 'package:UniPath/utils/color.dart';

class notificationCart extends StatefulWidget {
  final Notif notif;
  notificationCart({required this.notif});

  @override
  _notificationCartState createState() => _notificationCartState();
}

class _notificationCartState extends State<notificationCart> {
  late UserModel currentUser, otherUser;


  /*final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void otherUserProf() async {
    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.nt.otherUid)
        .get();

    otherUser = user(
      username: x.docs[0]['username'],
      fullname: x.docs[0]['fullname'],
      followers: x.docs[0]['followers'],
      following: x.docs[0]['following'],
      posts: [],
      description: x.docs[0]['description'],
      photoUrl: x.docs[0]['photoUrl'],
      phoneNumber: x.docs[0]['phoneNumber'],
      profType: x.docs[0]['profType'],
      uid: x.docs[0]['uid'],
    );

    var xy = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.nt.uid)
        .get();

    otherUser2 = user(
      username: xy.docs[0]['username'],
      fullname: xy.docs[0]['fullname'],
      followers: xy.docs[0]['followers'],
      following: xy.docs[0]['following'],
      posts: [],
      description: xy.docs[0]['description'],
      photoUrl: xy.docs[0]['photoUrl'],
      phoneNumber: xy.docs[0]['phoneNumber'],
      profType: xy.docs[0]['profType'],
      uid: xy.docs[0]['uid'],
    );

    if (currentUser != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void loadUserInfo() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;

    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _user.uid)
        .get();

    currentUser = user(
        followers: x.docs[0]['followers'],
        following: x.docs[0]['following'],
        username: x.docs[0]['username'],
        fullname: x.docs[0]['fullname'],
        phoneNumber: x.docs[0]['phoneNumber'],
        photoUrl: x.docs[0]['photoUrl'],
        description: x.docs[0]['description'],
        profType: x.docs[0]['profType'],
        uid: x.docs[0]['uid']
    );

    if (otherUser != null && otherUser2 != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }*/


  @override
  Widget build(BuildContext context) {
    if(widget.notif!.notifType == "like") {
      return Card(
        color: Colors.grey[200],
        margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.notif!.userPhotoURL),
                radius: 32.0,
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 5),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.notif!.username + " like your post.",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                              fontFamily: 'BrandonText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    else if (widget.notif!.notifType == "followRequest"){
        return Card(
          color: Colors.grey[200],
          margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/tr/a/ac/Acdc_Highway_to_Hell.JPG"),
                  radius: 32.0,
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ACDC_official" + " started to follow you.",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 10),

                            /*Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(currentUser.uid)
                                        .update({
                                      "followers": FieldValue.arrayUnion(
                                          [otherUser2.uid])
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(otherUser2.uid)
                                        .update({
                                      "following": FieldValue.arrayUnion(
                                          [currentUser.uid])
                                    });

                                    FirebaseFirestore.instance
                                        .collection('notifications')
                                        .doc(widget.nt.notifID)
                                        .update({
                                      "notifType": "follow",
                                    });

                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey[800],
                                    minimumSize: Size(20,10),
                                  ),
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20,),

                                TextButton(
                                  onPressed: () async {
                                    FirebaseFirestore.instance
                                        .collection('notifications')
                                        .doc(widget.nt.notifID)
                                        .delete();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey[800],
                                    minimumSize: Size(20,10),
                                  ),
                                  child: Text(
                                    "Decline",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
    else if (widget.notif!.notifType == "follow")  {
        return Card(
          color: Colors.grey[200],
          margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage("https://365psd.com/images/previews/b9d/kiss-band-42327.jpg"),
                  radius: 32.0,
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "The_Kiss_Band" + " started to follow you.",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
    else if(widget.notif!.notifType == "comment") {
      return Card(
        color: Colors.grey[200],
        margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.notif!.userPhotoURL),
                radius: 32.0,
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 5),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.notif.username + " comment on your post.",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                              fontFamily: 'BrandonText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    throw "undefined notification";
  }
}
