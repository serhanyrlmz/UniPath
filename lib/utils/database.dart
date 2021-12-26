
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';


class DBService {
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('users');

  Future addUserAutoID(String name, String surname, String mail,
      String token) async {
    userCollection.add({
      'name': name,
      'userToken': token,
      'email': mail
    })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addUser(String name, String mail, String token,
      String username, String password) async {
    userCollection.doc(token).set({
      'name': name,
      'userToken': token,
      'username': username,
      'email': mail,
      'password': password,
    });
  }
}





