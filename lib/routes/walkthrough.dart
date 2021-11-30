import 'package:UniPath/routes/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: WalkThrough(),
  ));
}


class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {

  //PART 1 START

  int currentPage = 0;  //1 POINT
  int lastPage = 3;     //1 POINT
  int counter=0;

  List<String> titles = [   //2 POINTS
    'Welcome',
    'Intro',
    'Profiles',
    'Content'
  ];
  List<String> headings = [ //2 POINTS
    'Awesome IT535 app',
    'Signup easily',
    'Create your profile',
    'Start meeting new people'
  ];
  List<String> captions = [   //2 POINTS
    'Your personal course material',
    'Just use your SU-Net account',
    'Update your flutter knowledge',
    'Connect with fellow flutterists'
  ];

  List<String> images = [   //2 POINTS
    'https://adtechresources.com/wp-content/uploads/2020/02/Mobile-Application.jpeg',
    'https://cdn.pttrns.com/764/8981_f.jpg',
    'https://cdn.pttrns.com/614/7772_f.jpg',
    'https://cdn.pttrns.com/614/7773_f.jpg',
  ];

  void nextPage() {
    if(currentPage < lastPage) {
      setState(() {
        currentPage += 1;
      });
    }
    counter++;
    if(counter==4){
      setState((){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return Welcome();
        }));
      });
    }

  }

  void prevPage() {
    if(currentPage > 0) {       //1 POINT
      setState(() {             //1 POINT
        currentPage -= 1;       //1 POINT
      });
    }
    counter--;
  }

  //PART 1 END

  //PART 2 START

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),   //1 POINT
      appBar: AppBar(                             //1 POINT
        backgroundColor: const Color(0xFFD1D1D6), //1 POINT
        title: Text(
          titles[currentPage].toUpperCase(),      //1 POINT, uppercase is not required if the list is all uppercase
          style: TextStyle(
            color: const Color(0xFF757575),       //1 POINT
            letterSpacing: -1,                    //1 POINT
          ),
        ),
        centerTitle: true,      //1 POINT
      ),
      body: SafeArea(       //2 POINTS
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  //1 POINT
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),  //1 POINT
                child: Text(
                  headings[currentPage],      //1 POINT
                  style: TextStyle(
                    fontSize: 32,             //1 POINT
                    fontWeight: FontWeight.w800,  //1 POINT
                    color: const Color(0xFF229A98), //1 POINT
                    letterSpacing: -1.0,    //1 POINT
                  ),
                ),
              ),
            ),


            Container(
              height: 280,  //1 POINT
              child: CircleAvatar(    //2 POINT
                backgroundImage: NetworkImage(images[currentPage]), //1 POINT: networkimage, 1 POINT: list item
                radius: 140,    //1 POINT
                backgroundColor: const Color(0xFF229A98),   //1 POINT
              ),
            ),

            Center(
              child: Text(
                captions[currentPage],    //1 POINT
                style: TextStyle(
                  fontSize: 24,   //1 POINT
                  fontWeight: FontWeight.w300,  //1 POINT
                  color: const Color(0xFF757575), //1 POINT
                  letterSpacing: -1.0,    //1 POINT
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),   //1 POINT
              child: Container(
                height: 80,
                child: Row(
                  children: [
                    OutlinedButton(   //1 POINT
                      onPressed: prevPage,   //1 POINT
                      child: Text(
                        'Prev',
                        style: TextStyle(
                          color: const Color(0xFF229A98),
                        ),
                      ),
                    ),


                    Spacer(),


                    Text(
                      '${currentPage+1}/${lastPage+1}', //1 POINT
                      style: TextStyle(
                        color: const Color(0xFF229A98),
                      ),
                    ),


                    Spacer(),


                    OutlinedButton(  //1 POINT
                      onPressed: nextPage,  //1 POINT
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
