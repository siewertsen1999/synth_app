import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:music_app/widgets/black_key.dart';
import 'dart:async';

import 'package:music_app/widgets/pad.dart';
import 'package:music_app/widgets/white_key.dart';

StreamController<bool> streamController = StreamController<bool>.broadcast();

class PianoPage extends StatefulWidget {

  late final Stream<bool> stream;
  late final StreamController updateStream;

  // List of all Pads
  List<WhiteKey> whiteKeys = [];
  List<BlackKey> blackKeys = [];
  final List<String> whiteKeyNames = [
    "C","D","E","F","G","A","B",
    "C","D","E","F","G","A","B",
    "C","D","E","F","G","A","B",
    "C","D","E","F","G","A","B",
    "C","D","E","F","G","A","B",
    "C","D","E","F","G","A","B",
    "C","D","E","F","G","A","B",
    "C","D","E","F","G","A","B",
  ];
  final List<String> blackKeyNames = [
    "x","C#","D#","x","f#","g#","a#",
    "x","C#","D#","x","f#","g#","a#",
    "x","C#","D#","x","f#","g#","a#",
    "x","C#","D#","x","f#","g#","a#",
    "x","C#","D#","x","f#","g#","a#",
    "x","C#","D#","x","f#","g#","a#",
    "x","C#","D#","x","f#","g#","a#",
    "x","C#","D#","x","f#","g#","a#",
  ];

  PianoPage(this.stream, this.updateStream);

  @override
  State<PianoPage> createState() => _PianoPageState();


  }


class _PianoPageState extends State<PianoPage> {

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
        body:
        Stack(
            children:[
        Container(
            width: displayWidth,
            alignment: Alignment.center,
            child:

            StaggeredGridView.countBuilder(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              itemCount:  56,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                WhiteKey temp = WhiteKey(widget.whiteKeyNames[index]);
                widget.whiteKeys.add(temp);
                return temp;
              },
              staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(4, 0.2),
            ),
        ),
          Container(
              height: displayHeight /2,
              width: displayWidth,
              alignment: Alignment.center,
              child:
            StaggeredGridView.countBuilder(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 2.0,
              itemCount:  56,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                  if(widget.blackKeyNames[index] != "x"){
                  BlackKey temp = BlackKey(widget.blackKeyNames[index]);
                  widget.blackKeys.add(temp);
                  return temp;
                }
                // TODO: not nice
                return Text("");
              },
              staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(4, 0.2),
            ),
          )]
            ),


        );


      // ]
      // 64 Pads




   // );

  }
}
