
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'package:image_picker/image_picker.dart';
import 'search.dart';
import 'announcements.dart';
import 'add.dart';
import 'settings.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:UniPath/routes/storage_service.dart';
import 'package:UniPath/utils/post.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;

  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
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

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }


  int _selectedIndex = 0;

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
          return Announcements();
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
          return Settings();
        }));
      }
    }
    );
  }
  @override void initState() { super.initState();  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),
        backgroundColor: AppColors.headingColor,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.people))
        ],

      ),

      body: Container(
        child: FutureBuilder(
          future: _loadImages(),
          builder: (context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> image =
                  snapshot.data![index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      dense: false,
                      leading: Image.network(image['url']),

                      trailing: IconButton(
                        onPressed: () => _delete(image['path']),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
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
