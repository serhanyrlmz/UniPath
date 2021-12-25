import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart'as firebase_core;
class Storage{
  final firebase_storage.FirebaseStorage storage= firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
    var filePath,
    String fileName )async {
    File files =File(filePath);

    try {
      await storage.ref('post/$fileName').putFile(files);

    }
    on firebase_core.FirebaseException catch(e){
      print(e);}

  }
  Future<firebase_storage.ListResult> listFiles() async{
    firebase_storage.ListResult results =await storage.ref('post').listAll();
    results.items.forEach((firebase_storage.Reference ref){
      print('Found file: $ref');
    });
    return results;


  }
}

