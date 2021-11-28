
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:music_app/pages/piano_page.dart';

class KeysState extends ChangeNotifier {
  FlutterMidi flutterMidi = FlutterMidi();
  final int gridSize;
  final int playSpeed;
  final Map<int, bool>_pressedKeys = {
    1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false, 8 : false, 9 : false, 10 : false, 11 : false, 12 : false, 13 : false, 14 : false, 15 : false,
    16 : false, 17 : false, 18 : false, 19 : false, 20 : false, 21 : false, 22 : false, 23 : false, 24: false, 25 : false, 26 : false, 27 : false, 28 : false, 29 : false, 30 : false
  };
  List<dynamic> _midiNotes = [];
  //The subscription provides events to the listener, and holds the callbacks used to handle the events.
  // The subscription can also be used to unsubscribe from the events, or to temporarily pause the events from the stream.
  //isPaused → bool
  //Whether the StreamSubscription is currently paused. [...]
  //runtimeType → Type
  //A representation of the runtime type of the object.
  late StreamSubscription _subscription;
  String _chosenSound = "Super Saw 3";


  KeysState({this.gridSize = 6, this.playSpeed = 125}){
    _midiNotes = List.generate(gridSize, (id) {
      return id;
    });

    rootBundle.load("lib/assets/20 Synth Soundfonts/${_chosenSound}.sf2").then((sf2) {
      flutterMidi.prepare(sf2: sf2, name: "${_chosenSound}.sf2");
    });
  }

  void changeSound(String sound){
    print("Sound Changed");
    _chosenSound = sound;
    rootBundle.load("lib/assets/20 Synth Soundfonts/${_chosenSound}.sf2").then((sf2) {
      flutterMidi.prepare(sf2: sf2, name: "${_chosenSound}.sf2");
    });
    notifyListeners();
  }

  bool get isPlaying => _subscription != null && !_subscription.isPaused;


  //TODO: Why Triggered and selected in 2 functions?
  bool? isButtonTrigerred(int pos) {
    return isKeySelected(pos);
  }

  bool? isKeySelected(int pos) {
    return _pressedKeys[pos];
  }

  void addKey(int pos) {
    _pressedKeys[pos] = true;
    notifyListeners();
  }

  void removeKey(int pos) {
    _pressedKeys[pos] = false;
    notifyListeners();
  }

  void play() {
    _subscription?.cancel();
    _subscription = Stream.periodic(
      Duration(milliseconds: playSpeed),
    ).listen((value) => {});
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }


  void playMidiNotes() {
    _pressedKeys..forEach((pos, isPressed) {
      if (isPressed) {
        flutterMidi.playMidiNote(midi: 48+pos);

        Future.delayed(Duration(milliseconds: 250),
                () => flutterMidi.stopMidiNote(midi: 48+pos));
      }
    });

    notifyListeners();
  }



}