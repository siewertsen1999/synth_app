import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/keys_state.dart';
import 'package:provider/provider.dart';

class BlackKey extends StatefulWidget{
  int id = 0;
  String name ="";
  bool _pressed = false;
  BlackKey(String whiteKeyNam, int id) {
    this.name = whiteKeyNam;
    this.id = id;
  }

  @override
  State<StatefulWidget> createState() => _BlackKeyState();

}

class _BlackKeyState extends State<BlackKey> {

  @override
  Widget build(BuildContext context) {
    return
    Consumer(builder: (BuildContext context, KeysState value, Widget? child) {
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
                 // widget._pressed = !widget._pressed;


                },
                style: ButtonStyle(
                  backgroundColor: widget._pressed? MaterialStateProperty.all(Colors.red) : MaterialStateProperty.all(Colors.black),
                ),
                child:
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
            )
        );
    },

    );

  }


}