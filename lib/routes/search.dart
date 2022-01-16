import 'package:UniPath/models/searchResult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:UniPath/utils/color.dart';
import 'package:UniPath/utils/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'notificationPage.dart';
import 'search.dart';
import 'add.dart';
import 'settings.dart';
import 'announcements.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:UniPath/models/searchResultCart.dart';

List<SearchResult> userResults = [];

class Search extends StatefulWidget {

  final UserModel currentUser;
  const Search({Key? key, this.currentUser}) : super(key: key);


  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<Search> {

  int _selectedIndex=0;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search');

  static const historyLength = 5;
  var results = [];
  List<String> _searchHistory = [];
  late SharedPreferences prefs;

  late String selectedTerm;

  late List<String> filteredSearchHistory;

  late FloatingSearchBarController controller;

  void _onItemTapped(int index){
    setState((){
      _selectedIndex=index;
      if(_selectedIndex==0) {
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return HomeScreen();
        }));}
      else if(_selectedIndex ==1){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return Search();
        }));
      }
      else if(_selectedIndex ==2){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return notificationPage();
        }));
      }
      else if(_selectedIndex ==3){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return Add();
        }));
      }
      else if(_selectedIndex ==4){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){

          return Setting();
        }));
      }

    }
    );
  }

  List<String> filteredSearchTerms({
    @required String? filter,
  }) {

    // Filtering among search history to make search easy
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((element) => element.startsWith(filter))
          .toList();
    } else {
      // if nothing written we can return all search history
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String element) {
    // What we want to do is if the added search term is already exist
    // We dont need to duplicate it
    if (_searchHistory.contains(element)) {
      putSearchTermFirst(element);
      return;
    } else {
      // if element is not exist
      // you may add normally
      _searchHistory.add(element);
      if (_searchHistory.length > historyLength) {
        // remove oldest search until length is proper to add new one
        _searchHistory.removeRange(0, _searchHistory.length - historyLength);
      }
      filteredSearchHistory = filteredSearchTerms(filter: null);
    }
    prefs.setStringList("search_history", _searchHistory);
  }

  void deleteSearchTerm(String element) {
    _searchHistory.removeWhere((willDelete) => willDelete == element);
    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void putSearchTermFirst(element) {
    // if element is already exist will be deleted
    deleteSearchTerm(element);

    // add to the first
    addSearchTerm(element);
  }

  @override
  void initState() {
    super.initState();
    loadSearchHistory();
    // We are displaying this variable in screen and
    // we need to be sure it is filtered from scratch
    controller = FloatingSearchBarController();
  }

  void loadSearchHistory() async {
    prefs = await SharedPreferences.getInstance();
    var _sh = prefs.getStringList("search_history");
    if (_sh == null) {
      prefs.setStringList("search_history", []);
    } else {
      // safe to get
      _searchHistory = _sh;
    }
  }

  void saveHistory() {
    prefs.setStringList("search_history", _searchHistory);
  }

  @override
  void dispose() {
    saveHistory();
    controller.dispose();
    super.dispose();
  }

  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  void checkIfExist(String src) {
    bool ch = false;
    for (int i = 0; i < results.length; i++) {
      if (src == results[i].identifier /*||
          src == results[i].description*/) ch = true;
    }
    if (ch == false) {
      crashlytics.setCustomKey("search result not found:", src);
    }
  }

  void getSearchResults(query) async {

    var users = await FirebaseFirestore.instance
        .collection("users")
        .where('username', isGreaterThanOrEqualTo: query,

      isLessThan: query.substring(0, query.length - 1) +
          String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),

    )
        .get();
    //.where('activation', isEqualTo: "active")
    users.docs.forEach((doc) => {
      if (doc['activation'] == "active") {
        userResults.add(
            SearchResult(identifier: doc['username'],
                description: doc['name'],
                itemID: doc['uid'],
                photoUrl: doc['photoUrl'])
            ),
      }
    });

    setState(() {
      selectedTerm = query;
      results = userResults;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:customSearchBar,
        automaticallyImplyLeading:false,
        backgroundColor: AppColors.headingColor,
        actions: <Widget>[
          IconButton(onPressed: (){
            setState(() {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = const ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
            });
          },
              icon: customIcon)
        ],
      ),
      body: FloatingSearchBar (
        automaticallyImplyBackButton: false,
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchResultsListView(
            searchTerm: selectedTerm,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? 'Enter to search',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Start typing...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filteredSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          userResults = [];
          checkIfExist(query);
          getSearchResults(query);
          addSearchTerm(query);
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(builder: (context) {
                filteredSearchHistory = filteredSearchTerms(filter: null);
                if (filteredSearchHistory.isEmpty &&
                    controller.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'No history exist. Start to explore :)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (filteredSearchHistory.isEmpty) {
                  // search history not found but user typing something
                  return ListTile(
                    title: Text(controller.query),
                    leading: const Icon(Icons.search),
                    // for each type we need to add characters to history which is writing...
                    onTap: () {
                      setState(() {
                        addSearchTerm(controller.query);
                        selectedTerm = controller.query;
                      });
                      controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory
                        .map((e) => ListTile(
                      title: Text(
                        e,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: const Icon(Icons.history),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            deleteSearchTerm(e);
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          putSearchTermFirst(e);
                          selectedTerm = e;
                        });
                        controller.close();
                      },
                    ))
                        .toList(),
                  );
                }
              }),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.announcement),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label:'home', backgroundColor: AppColors.loginBackBottom),

        ],
        type: BottomNavigationBarType.shifting,
        currentIndex:_selectedIndex,
        iconSize:40,
        onTap:_onItemTapped,

      ),
    );
  }
}


class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  Widget buildSearchResults(
      List<SearchResult> results, BuildContext context, int index) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text(""),
              subtitle: Text(""),
            ),
          ],
        ),
      ),
    );
  }

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  noResultsFound(context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
                "No results found!"
            ),
          ),
          Container(
            width: double.infinity,
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Explore Sinappses!',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);
    return ListView(
        padding: EdgeInsets.only(top: 5),
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              'Users',
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(),
          Column(
            children: (userResults == null || userResults.isEmpty) ? noResultsFound(context) : userResults
                .map((element) => searchResultCart(
              sr: element,
            )).toList(),
          ),
        ]);
  }
}
