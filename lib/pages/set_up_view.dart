import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetUpView extends StatefulWidget{
  String selectedSound = "";
  @override
  State<StatefulWidget> createState() => _SetUpViewState();
  List<String> _sounds = ["Acid SQ Neutral", "Analog Saw", "Beeper", "CandyBee", "Dance Trance", "Dirty Sub", "FM Modulator", "Happy Mellow","Hyper Saw",
    "Kaputt Sine", "PerfectSine", "Plastic Strings", "Poly Special Mono", "Pulse Wobbler", "Sine Wave", "Solar Wind", "Super Saw 1", "Super Saw 2", "Super Saw 3", "Synth E"];
}

class _SetUpViewState extends State<SetUpView>{
  String dropDownHint = "Select Sound";
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(
            toolbarHeight: 33,
            backgroundColor: Colors.blueGrey,
          ),
          body: Row(
              children: [
                SizedBox(width: 10,),
                Column(
                  children: [
                        DropdownButton<String>(
                          hint: Text(dropDownHint),
                        items: widget._sounds.map((String value) {
                              return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              );
                              }).toList(),

                            onChanged: (String? value) {
                              setState(() {
                                print(value!);
                                dropDownHint = value;
                                widget.selectedSound = value!;
                              });
                            },
                            )

                  ],
                )
              ]
          )

      );}
}