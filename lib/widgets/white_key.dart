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
                  Provider.of<KeysState>(context).addKey(widget.id);
                  Provider.of<KeysState>(context).playMidiNotes();
                  setState(() {
                    widget._pressed = !widget._pressed;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: widget._pressed? MaterialStateProperty.all(Colors.red) : MaterialStateProperty.all(Colors.white70),
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