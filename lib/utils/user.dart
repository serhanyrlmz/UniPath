import 'package:cloud_firestore/cloud_firestore.dart';

final userReference = FirebaseFirestore.instance.collection('users');

class UserModel {
  final String? id;
  final String? username;
  final String? bio;
  final String? email;
  final String? name;
  final String? photoUrl;
  final List<dynamic>? followers;
  final List<dynamic>? following;
  final List<dynamic>? posts;

  UserModel({
    this.id,
    this.username,
    this.bio,
    this.email,
    this.name,
    this.photoUrl,
    this. followers,
    this.following,
    this.posts,
  });
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      bio: doc['bio'],
      username: doc['username'],
      email: doc['email'],
      name: doc['name'],
      photoUrl: doc['photoUrl'],
      followers: doc['followers'],
      following: doc['following'],
      posts: doc['posts'],
    );
  }
}
