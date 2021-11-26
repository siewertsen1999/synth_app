import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/widgets/tab_navigator.dart';


class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}


class AppState extends State<AppNavigator> {
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    //"Page3": GlobalKey<NavigatorState>(),
    //"Page4": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;


  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
          !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
          //  check if we deeper in the stack of the current page
          if (isFirstRouteInCurrentTab) {
            // check if we're not on first Page / LiveFeed -> If true return to Live Feed
            if (_currentPage != "Page1") {
              _selectTab("Page2", 1);
              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: Stack(
              children: <Widget>[
                _buildOffstageNavigator("Page1"),
                _buildOffstageNavigator("Page2"),
                //_buildOffstageNavigator("Page3"),
                //_buildOffstageNavigator("Page4"),
              ]
          ),
          bottomNavigationBar: SizedBox(
            height: 50,
            child:

            BottomNavigationBar(
              selectedItemColor:Colors.orange,
              unselectedItemColor: Colors.white,
              backgroundColor: Colors.black12,
              type: BottomNavigationBarType.fixed,

              onTap: (int index) {
                _selectTab(pageKeys[index], index);
              },
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(
                  icon:  Padding(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Icon(Icons.update, size: 18),
                  ),
                  label: 'Pad',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Icon(Icons.filter_list_alt , size: 18),
                  ),
                  label: 'Piano',
                ),
                // TODO: change heart Icon to bookmark_add_outlined ?
                /*
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Icon(Icons.bookmarks_outlined, size: 33),
                  ),
                  label: 'Merkzettel',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Icon(Icons.account_circle, size: 33),),
                  label: 'Profil',
                ),

                 */
              ],

            ),
          ),
        )
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}