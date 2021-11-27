import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys_state.dart';

class WhiteKey extends StatefulWidget{
  int id = 0;
  bool _pressed = false;
  Color pressedColor = Colors.white12;
  String name ="";

  WhiteKey(String whiteKeyNam, int id){
    this.name = whiteKeyNam;
    this.id = id;
  }

  @override
  State<StatefulWidget> createState() => _WhiteKeyState();


}

class _WhiteKeyState extends State<WhiteKey> {

  @override
  Widget build(BuildContext context) {
      return
        Container(
            decoration: BoxDecoration( borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.blueGrey),),
            child:
            ElevatedButton(
                onPressed:  () {
                  print("pressed");
                  Provider.of<KeysState>(context, listen: false).addKey(widget.id);
                  Provider.of<KeysState>(context, listen: false).playMidiNotes();
                  Provider.of<KeysState>(context, listen: false).removeKey(widget.id);
                  },
                style: ButtonStyle(
                  backgroundColor: widget._pressed? MaterialStateProperty.all(Colors.red) : MaterialStateProperty.all(Colors.white54),
                ),
                child:
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
            )
        );
    }



}