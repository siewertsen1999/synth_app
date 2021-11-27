import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:music_app/widgets/black_key.dart';
import 'dart:async';

import 'package:music_app/widgets/pad.dart';
import 'package:music_app/widgets/white_key.dart';

StreamController<bool> streamController = StreamController<bool>.broadcast();

class PianoPage extends StatelessWidget {

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

  final List<String> keys = [
    "C","C#","D","D#","E","F","F#","G","G#","A","A#",
    "C","C#","D","D#","E","F","F#","G","G#","A","A#",
    "C","C#","D","D#","E","F","F#","G","G#","A","A#",
    "C","C#","D","D#","E","F","F#","G","G#","A","A#",
    "C","C#","D","D#","E","F","F#","G","G#","A","A#",
    "C","C#","D","D#","E","F","F#","G","G#","A","A#",
    "C"

  ];

  PianoPage(this.stream, this.updateStream);

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
        Container(
            width: displayWidth,
            child:
            GridView.count(
                physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                childAspectRatio: 6,
                mainAxisSpacing: 1,
                crossAxisCount: 1,
                children:
                List.generate(keys.length, (index) {
                  if (keys[index].substring(1) == "#") {
                    print("${keys[index].substring(1)}");
                    return BlackKey((keys[index]));
                  }
                  else {
                    return WhiteKey(keys[index]);
                  }
                })))
    );



  }
}
