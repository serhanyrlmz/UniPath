import 'package:UniPath/routes/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:UniPath/utils/analytics.dart';

class WalkThrough extends StatefulWidget {
  const WalkThrough({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _WalkThroughState createState() => _WalkThroughState();
}

//void main() {
//  runApp(MaterialApp(
//    home: WalkThrough(analytics: analytics, observer: observer),
//  ));
//}

class _WalkThroughState extends State<WalkThrough> {

  //PART 1 START

  int currentPage = 0;
  int lastPage = 2;
  int counter=0;

  List<String> titles = [
    'Welcome to UniPath App',
    'Feed',
    'Profiles'
  ];
  List<String> headings = [
    'Meet and make friends',
    'Instant access to all students opinions and activities',
    'Create your profile'

  ];
  List<String> captions = [
    'Get access to all university student clubs and activities all around the world',
    'Just provide us your student id',
    'Update your opinion'

  ];

  List<String> images = [
    'assets/logo.jpeg',
    'assets/logo.jpeg',
    'assets/logo.jpeg'
  ];



  void nextPage() {
    if(currentPage < lastPage) {
      setState(() {
        currentPage += 1;
      });
    }
    counter++;
    if(counter==3){
      setState((){
        Navigator.popAndPushNamed(context, "/welcome");
        //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          //return Welcome(analytics: analytics, observer: observer);
        //}));
      });
    }

  }

  void prevPage() {
    if(currentPage > 0) {
      setState(() {
        currentPage -= 1;
      });
    }
    counter--;
  }

  //PART 1 END

  //PART 2 START

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD1D1D6),
        title: Text(
          titles[currentPage].toUpperCase(),
          style: TextStyle(
            color: const Color(0xFF757575),
            letterSpacing: -1,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  headings[currentPage],
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF229A98),
                    letterSpacing: -1.0,
                  ),
                ),
              ),
            ),


            Container(
              height: 280,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.jpeg'),
                radius: 140,
                backgroundColor: const Color(0xFF229A98),
              ),
            ),

            Center(
              child: Text(
                captions[currentPage],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF757575),
                  letterSpacing: -1.0,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 80,
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: prevPage,
                      child: Text(
                        'Prev',
                        style: TextStyle(
                          color: const Color(0xFF229A98),
                        ),
                      ),
                    ),


                    Spacer(),


                    Text(
                      '${currentPage+1}/${lastPage+1}',
                      style: TextStyle(
                        color: const Color(0xFF229A98),
                      ),
                    ),


                    Spacer(),


                    OutlinedButton(
                      onPressed: nextPage,
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: const Color(0xFF229A98),
                        ),
                      ),
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
}
