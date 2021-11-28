
import 'package:flutter/material.dart';
import 'package:music_app/pages/drums.dart';
import 'dart:async';

import 'package:music_app/pages/pad_page.dart';
import 'package:music_app/pages/piano_page.dart';

int count = 0;

StreamController<bool> streamControllerHome = StreamController<bool>.broadcast(sync: true);
StreamController<bool> streamControllerBrowser = StreamController<bool>.broadcast(sync: true);
StreamController<bool> streamControllerFavorites = StreamController<bool>.broadcast(sync: true);
StreamController<bool> streamControllerProfile = StreamController<bool>.broadcast(sync: true);
StreamController<bool> updateStream = StreamController<bool>.broadcast(sync: true);

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key, required this.navigatorKey, required this.tabItem}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  @override
  void initState() {
    super.initState();
    if (!updateStream.hasListener) {
      updateStream.stream.listen((update) {
        updateStreams(update);
      });
    }
  }

  void updateStreams(bool update) {
    streamControllerHome.add(true);
    streamControllerBrowser.add(true);
    streamControllerFavorites.add(true);
    streamControllerProfile.add(true);
  }

  @override
  Widget build(BuildContext context) {

    Widget child = PadPage(streamControllerHome.stream, updateStream);
    if(widget.tabItem == "Page1") {
      child = PianoPage(streamControllerBrowser.stream, updateStream);
    }
    else if(widget.tabItem == "Page2") {
      child = Drums(streamControllerHome.stream, updateStream);
    }
    else if (widget.tabItem == "Page3") {
      child = PadPage(streamControllerHome.stream, updateStream);

    } /*else if (widget.tabItem == "Page4"){
      child = ProfilePage(streamControllerProfile.stream, updateStream);
    }
*/
    // TODO: add Profile Page

    return
      Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) => child
          );
        },
      );
  }
}