import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';

import 'package:music_app/widgets/pad.dart';

StreamController<bool> streamController = StreamController<bool>.broadcast();

class PadPage extends StatefulWidget {

  late final Stream<bool> stream;
  late final StreamController updateStream;

  // List of all Pads
  List<Pad> allPads = [];

  PadPage(this.stream, this.updateStream);

  @override
  State<PadPage> createState() => _PadPageState();
}

class _PadPageState extends State<PadPage> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    double displayWidth = _mediaQueryData.size.width;
    double displayHeight = _mediaQueryData.size.height;
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 33,
            backgroundColor: Colors.black12,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child:
                      // Header
                      Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'My Synth',
                      style: TextStyle(
                        // Shaddow is used to get Distance to the underline -> TextColor itself is transparent
                        shadows: [
                          Shadow(
                              color: Color.fromRGBO(240, 240, 240, 1),
                              offset: Offset(0, -6))
                        ],
                        //fontFamily: '....',
                        fontSize: 21,
                        letterSpacing: 3,
                        color: Colors.transparent,
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.orange,
                        decorationThickness: 4,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        body: Container(
            height: displayHeight - 60 -33,
            width: displayHeight - 60 -33,
            alignment: Alignment.center,
            child:
            // 64 Pads
            StaggeredGridView.countBuilder(
              crossAxisCount: 8,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              itemCount: 64,
                itemBuilder: (BuildContext context, int index){
                Pad temp = Pad();
                widget.allPads.add(temp);
                return temp;
              },
              // You want a fixed number of cells => use StaggeredTile.count.
              // You want a fixed extent => use StaggeredTile.extent.
              // You want a variable extent, defined by the content of the tile itself => use StaggeredTile.fit.
              staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 1),


              ))
        );

  }
}
