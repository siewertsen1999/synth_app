
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_midi/flutter_midi.dart';

class KeysState extends ChangeNotifier {
  FlutterMidi flutterMidi = FlutterMidi();
  final int gridSize;
  final int playSpeed;
  final Map<int, bool>_pressedKeys = Map();
  List<dynamic> _midiNotes = [];
  //The subscription provides events to the listener, and holds the callbacks used to handle the events.
  // The subscription can also be used to unsubscribe from the events, or to temporarily pause the events from the stream.
  //isPaused → bool
  //Whether the StreamSubscription is currently paused. [...]
  //runtimeType → Type
  //A representation of the runtime type of the object.
  late StreamSubscription _subscription;



  KeysState({this.gridSize = 6, this.playSpeed = 125}){
    _midiNotes = List.generate(gridSize, (id) {
      return 12 + id;
    });

    rootBundle.load("lib/assets/20 Synth Soundfonts/Sine Wave.sf2").then((sf2) {
      flutterMidi.prepare(sf2: sf2, name: "Sine Wave.sf2");
    });
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
        flutterMidi.playMidiNote(midi: pos);

        Future.delayed(Duration(milliseconds: 100),
                () => flutterMidi.stopMidiNote(midi: _midiNotes[pos]));
      }
    });

    notifyListeners();
  }



}