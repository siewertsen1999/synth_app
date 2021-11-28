import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:music_app/keys_state.dart';
import 'package:music_app/pages/set_up_view.dart';
import 'package:music_app/widgets/black_key.dart';
import 'dart:async';

import 'package:music_app/widgets/pad.dart';
import 'package:music_app/widgets/white_key.dart';
import 'package:music_app/widgets/black_key.dart';
import 'package:music_app/widgets/white_key.dart';
import 'package:provider/provider.dart';

StreamController<bool> streamController = StreamController<bool>.broadcast();

class PianoPage extends StatefulWidget {
  List<String> _sounds = [
    "Acid SQ Neutral",
    "Analog Saw",
    "Beeper",
    "CandyBee",
    "Dance Trance",
    "Dirty Sub",
    "FM Modulator",
    "Happy Mellow",
    "Hyper Saw",
    "Kaputt Sine",
    "PerfectSine",
    "Plastic Strings",
    "Poly Special Mono",
    "Pulse Wobbler",
    "Sine Wave",
    "Solar Wind",
    "Super Saw 1",
    "Super Saw 2",
    "Super Saw 3",
    "Synth E"
  ];

  final List<String> keys = [
    "C",    "C#",    "D",    "D#",    "E",    "F",    "F#",    "G",    "G#",    "A",    "A#",    "B",    "C",    "C#",    "D",    "D#",    "E",    "F",    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B",
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B",
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B",
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B",
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B",
    "C"
  ];

  late final Stream<bool> stream;
  late final StreamController updateStream;


  // List of all Pads
  List<WhiteKey> whiteKeys = [];
  List<BlackKey> blackKeys = [];
  PianoPage(this.stream, this.updateStream);



  @override
  State<StatefulWidget> createState() => _PianoPageState();
}

class _PianoPageState extends State<PianoPage>{
  String dropDownHint = "Super Saw 3";
  String selectedSound = "";
  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    double displayWidth = _mediaQueryData.size.width;
    // double displayHeight = _mediaQueryData.size.height;
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return
      Consumer(builder: (BuildContext context, KeysState value, Widget? child) {
        return
          Scaffold(
              appBar: AppBar(
                  toolbarHeight: 33,
                  backgroundColor: Colors.blueGrey,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        hint: Text(dropDownHint),
                        items: widget._sounds.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value2) {
                          setState((){
                            value.changeSound(value2!);
                            print(value2!);
                            dropDownHint = value2;
                            selectedSound = value2;
                          });

                        },
                      ),

                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SetUpView()));
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0))),
                            padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                          ),
                          child: Text("SynthSetup",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ))),
                    ],
                  )),
              body: Container(
                  width: displayWidth,
                  child: GridView.count(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      childAspectRatio: 6,
                      mainAxisSpacing: 1,
                      crossAxisCount: 1,
                      children: List.generate(widget.keys.length, (index) {
                        if (widget.keys[index].substring(1) == "#") {
                          print("${widget.keys[index].substring(1)}");
                          return BlackKey((widget.keys[index]), index);
                        } else {
                          return WhiteKey(widget.keys[index], index);
                        }
                      }))));
      });
  }


}
