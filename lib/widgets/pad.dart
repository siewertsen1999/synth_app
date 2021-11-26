import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pad extends StatefulWidget {
  bool pressed = false;
  Color pressedColor = Colors.white12;
  @override
  State<StatefulWidget> createState() => _PadState();
}

class _PadState extends State<Pad>{
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
           decoration: BoxDecoration(
             border: Border.all(color: Colors.blueGrey),
             borderRadius: BorderRadius.circular(5),
             color: widget.pressedColor,
           ),
           padding: EdgeInsets.all(10),
         )));
  }

  setColor(){
    widget.pressed = !widget.pressed;
    if(widget.pressed) widget.pressedColor = Colors.orange;
    else widget.pressedColor = Colors.white12;
  }

}

