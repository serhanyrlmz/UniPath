import 'package:flutter/material.dart';

class Notif {
  final String userPhotoURL;
  final String username;
  final String notifType;
  //final String pid;
  //final String newUserId;
  //final String otherUid;
  final String postPhotoURL;
  //final String notifID;
//String date;

  Notif({ required this.userPhotoURL,  required this.username,  required this.notifType, this.postPhotoURL = ""});
  //Notif({ required this.userPhotoURL,  required this.username,  required this.notifType, this.pid = "",  required this.newUserId,  required this.otherUid, this.postPhotoURL = "",  required this.notifID});
}