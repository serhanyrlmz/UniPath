import 'package:UniPath/models/user.dart';
import 'package:UniPath/utils/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'package:UniPath/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:UniPath/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'profile.dart';
import 'package:UniPath/routes/EditProfile.dart';
import 'package:UniPath/utils/database.dart';
import 'package:UniPath/routes/HomePage.dart';
import 'package:UniPath/utils/user.dart';
import 'package:UniPath/utils/postCard.dart';

class Profile extends StatefulWidget {


  late final FirebaseAnalytics analytics;
  late final FirebaseAnalyticsObserver observer;
  late final Post post;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = PageController(initialPage: 0);

  Future<void> PostOptions(String pid,String title, String content) async {
    print(pid);


    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        ),
        title: const Text(
          'Post Options',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // message: const Text('',
        // style: TextStyle(color: Colors.black, fontSize: 15)),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Edit'),
            onPressed: () async {}
             // List<String> newPost = await Navigator.of(context).push(
                //  MaterialPageRoute(
                  //    builder: (context) => EditPost( caption: title,text: content)));

             // if(newPost != null){
               // await FirebaseFirestore.instance
                //    .collection('posts')
                 //   .doc(pid) //find this
                  //  .update({'title':newPost[0],'content':newPost[1]});
             // }
             // Navigator.pop(context);
           // },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {

              await FirebaseFirestore.instance
                  .collection('posts')
                  .doc(pid) //find this
                  .delete();

              Navigator.pop(context);
              setState(() {

              });

            },
          )
        ],
      ),
    );
  }

  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "",
      fullname = "",
      phoneNumber = "",
      photoUrl = "",
      description = "",
      uid = "";
  List<dynamic> postsUser = [];
  List<dynamic> posts = [];
  //var userInff;
  late user currentUser;
  String activation = "";
  void _loadUserInfo() async {
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser!;
    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _user.uid)
        .get();

    //.then((QuerySnapshot querySnapshot) {
    // querySnapshot.docs.forEach((doc) async {
    //print(doc['username'] + " " + doc['fullname']);
    //print(doc.data()['username'])

    //});
    //});
    setState(() {
      username = x.docs[0]['username'];
      fullname = x.docs[0]['fullname'];
      followers = x.docs[0]['followers'];
      following = x.docs[0]['following'];
      phoneNumber = x.docs[0]['phoneNumber'];
      photoUrl = x.docs[0]['photoUrl'];
      description = x.docs[0]['description'];
      postsUser = x.docs[0]['posts'];
      uid = x.docs[0]['uid'];
      activation = x.docs[0]['activation'];
    });
  }
  bool feedLoading = true;
  int postsSize = 0;
  void _loadUserProf() async {
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser!;

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
    uid = x.docs[0]['uid'];
    activation = x.docs[0]['activation'];
    var profPosts = await FirebaseFirestore.instance
        .collection('posts')
        .where('userid', isEqualTo: uid)
        .get();
    postsSize = profPosts.size;
    profPosts.docs.forEach((doc) =>
    {
      posts.add(
          Post(
              pid: doc['pid'],
              username: doc['username'],
              userid: doc['userid'],
              userPhotoUrl: doc['userPhotoURL'],
              postPhotoURL: doc['postPhotoURL'],
              title: doc['title'],
              content: doc['content'],
              date: DateTime.fromMillisecondsSinceEpoch(
                  doc['date'].seconds * 1000),
              likes: doc['likes'],
              comments: doc['comments'],
              topics: doc['topics'],
              isLiked: doc['likes'].contains(uid) ? true : false, activation: ''
          )
      )
    });

    posts..sort((a, b) => b.date.compareTo(a.date));
    setState(() {
      print("its in");
      feedLoading = false;
    });
  }
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];
    FirebaseFirestore storage = FirebaseFirestore.instance;
    final ListResult result = (await storage.collection('posts').get()) as ListResult;
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,

      });
    });

    return files;
  }

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadUserProf();
  }

  Widget build(BuildContext context) {
    currentUser = user(
        username: username,
        fullname: fullname,
        followers: followers,
        following: following,
        posts: postsUser,
        description: description,
        photoUrl: photoUrl,


        uid: uid, profType:false,

    );
    //_loadUserInfo();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            toolbarHeight: 48.0,
            leading: IconButton(
              color: Colors.grey[300],
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()));
              },
            ),

            title: Text(
              username,
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextButton(
                          child: Text('Followers',
                            style: TextStyle(
                              fontFamily: 'BrandonText',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          ),
                          onPressed: () {}
                            //Navigator.push(
                               // context,
                                //MaterialPageRoute(
                                    //builder: (context) =>
                                        //Followers(currentUser: currentUser)));
                         // }
                      ),
                      Text(
                        '${followers.length}',
                        style: TextStyle(
                          fontFamily: 'BrandonText',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(photoUrl),
                    radius: 56.0,
                  ),
                  Column(
                    children: <Widget>[
                      TextButton(
                          child: Text('Following',
                            style: TextStyle(
                              fontFamily: 'BrandonText',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          ),
                          onPressed: () {}
                           // Navigator.push(
                           //     context,
                           //     MaterialPageRoute(
                            //        builder: (context) =>
                            //            Following(currentUser: currentUser)));
                        //  }
                      ),
                      Text(
                        '${following.length}',
                        style: TextStyle(
                          fontFamily: 'BrandonText',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '${fullname}',
                        style: TextStyle(
                          fontFamily: 'BrandonText',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '${description}',
                        style: TextStyle(
                          fontFamily: 'BrandonText',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 3.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 90,
                        height: 40,

                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Posts',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: 'BrandonText',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '$postsSize',
                        style: TextStyle(
                          fontFamily: 'BrandonText',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 90,
                        height: 40,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.grey[750],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side:
                            BorderSide(width: 2, color: Colors.blueAccent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 2),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontFamily: 'BrandonText',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfile()));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Divider(
                color: Colors.grey[800],
                height: 20,
                thickness: 2.0,
              ),


        ]),
      ),
    ));
  }
}
