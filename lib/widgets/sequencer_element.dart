import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/pages/drums.dart';

class SequencerElement extends StatefulWidget {
  int index = 0;
  bool pressed = false;
  Color pressedColor = Colors.black38;
  @override
  State<StatefulWidget> createState() => _SequencerElementState();

  SequencerElement(int i){
    this.index = i;
  }
}

class _SequencerElementState extends State<SequencerElement>{

  @override
  Widget build(BuildContext context) {
   return
   InkWell(
     onTap: () {
       setState(() {
         setColor();
       });
     },
     child:
     Padding(
         padding: EdgeInsets.all(1),
         child: Container(
           alignment: Alignment.center,
           child: Text("${widget.index}"),
           decoration: BoxDecoration(
               color: widget.pressedColor,
               borderRadius: BorderRadius.circular(15)),
         ))
   );
  }

  setColor(){
    widget.pressed = !widget.pressed;
    if(widget.pressed) widget.pressedColor = Colors.teal;
    else widget.pressedColor = Colors.black38;
  }

}

