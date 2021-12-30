import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String pid;
  String username;
  String userid;
  String userPhotoUrl;
  String content;
  String title;
  DateTime date;
  String postPhotoURL;
  List<dynamic> comments;
  List<dynamic> likes;
  List<dynamic> topics;
  String activation;
  // ABOUT UI
  bool isLiked;

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      username: doc['username'],
      date: DateTime.fromMillisecondsSinceEpoch(doc['date'].seconds * 1000),
      title: doc['title'],
      userPhotoUrl: doc['userPhotoURL'],
      content: doc['content'],
      pid: doc['pid'],
      userid: doc['userid'],
      comments: doc['comments'],
      likes: doc['likes'],
      topics: doc['topics'],
      postPhotoURL: doc['postPhotoURL'],
      activation: doc['activation'],
    );
  }



  Post({required this.pid, required this.username, required this.userid, required this.userPhotoUrl, required this.content, required this.title, required this.date, required this.comments, required this.likes, required this.topics, this.isLiked=false, required this.postPhotoURL, required this.activation});
}