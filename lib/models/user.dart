import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  String username;
  String fullname;
  String photoUrl;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> posts;
  String description;
  bool profType;
  String uid;
  //String uid;
  //String activation;
  user(
      {required this.username,
        required this.fullname,
        required this.followers,
        required this.following,
        required this.posts,
        required this.description,
        required this.photoUrl,
        required this.profType,
        required this.uid});
  //this.uid,
  //this.activation});

  user.fromData(Map<String, dynamic> data)
      : username = data['username'],
        fullname = data['fullname'],
        followers = data['followers'],
        following = data['following'],
        posts = data['posts'],
        description = data['description'],
        photoUrl = data['photoUrl'],
        profType = data['profType'],
        uid = data['uid'];
  //activation = data['activation'];

  factory user.fromDocument(DocumentSnapshot doc) {
    return user(
      username: doc['username'],
      fullname: doc['fullname'],
      followers: doc['followers'],
      following: doc['following'],
      posts: doc['posts'],
      description: doc['description'],
      photoUrl: doc['photoUrl'],
      profType: doc['profType'],
      uid: doc['uid'],
      //activation: doc['activation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullname': fullname,
      'followers': followers,
      'following': following,
      'posts': posts,
      'description': description,
      'photoUrl': photoUrl,
      'profType': profType,
      'uid': uid,
      //'activation': activation
    };
  }

//String getUsername(String userid) {
//  if (uid == userid) return username;
// }
}
