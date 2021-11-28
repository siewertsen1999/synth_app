import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sequencer/global_state.dart';
import 'package:flutter_sequencer/models/instrument.dart';
import 'package:flutter_sequencer/models/sfz.dart';
import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:music_app/widgets/sequencer_element.dart';

class Drums extends StatefulWidget{

  late final Stream<bool> stream;
  late final StreamController updateStream;

  Drums(this.stream, this.updateStream);
  @override
  State<StatefulWidget> createState() => _DrumsState();
}

class _DrumsState extends State<Drums>{
  final sequence = Sequence(tempo: 120.0, endBeat: 8.0);
  // Future List with tracks
  late List<Track> tracklist = [];
  Track? selectedTrack;
  bool isPlaying = false;
  List<SequencerElement> seqElements = [];
  Map<int, double> trackVolumes = {};

  double tempo = 120.0;
  double position = 0.0;
  @override
  void initState() {
    //This will keep the audio engine running even when all sequences are paused.
    // Set this to true if you need to trigger sounds when the sequence is paused.
    // Don't do it otherwise, since it will increase energy usage
    GlobalState().setKeepEngineRunning(true);
    print("go");
  final instruments = [
    //To load user-provided or downloaded sounds from the filesystem, isAsset: false -> other option GlobalState().setKeepEngineRunning(true) before init instruments
    //SfzInstrument(
    ////  isAsset: false,
    //),
    //Sf2Instrument(path: "lib/assets/20 Synth Soundfonts/Beeper.sf2", isAsset: true),
    //Sf2Instrument(path: "lib/assets/20 Synth Soundfonts/Analog Saw.sf2", isAsset: true),
    RuntimeSfzInstrument(
        id: "Generated Synth",
        // This SFZ doesn't use any sample files, so just put "/" as a placeholder.
        sampleRoot: "/",
        isAsset: false,
        // Based on the Unison Oscillator example here:
        // https://sfz.tools/sfizz/quick_reference#unison-oscillator
        sfz: Sfz(groups: [
          SfzGroup(regions: [
            SfzRegion(sample: "*saw", otherOpcodes: {
              "oscillator_multi": "5",
              "oscillator_detune": "50",
            })
          ])
        ])),

    // TODO: adding more than one instrument
  ];

    print("instrumentLength  =  ${instruments.length}");
    // TODO: Create Tracks does not fill List with Tracks

    sequence.createTracks(instruments).then((tracks) {
      print("inside create Tracks ");
      tracks.forEach((track) {
        trackVolumes[track.id] = 0.0;
      });
      setState(() {
        print("setState works");
        this.tracklist == tracks;
        this.selectedTrack = tracks[0];
      });

    });
    print("after create Tracks");
  }
  fillSeqElements(){
    if(seqElements.isEmpty) {
      for (int i = 1; i <= 64; i++) {
        seqElements.add(SequencerElement(i));
      }
    }
  }

  handleTogglePlayPause() {
    if (isPlaying) {
      sequence.pause();
    } else {
      sequence.play();
    }
  }




  @override
  Widget build(BuildContext context) {

    fillSeqElements();
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    double displayWidth = _mediaQueryData.size.width;
    double displayHeight = _mediaQueryData.size.height;
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    print("go");
    initState();
    print("init");
    sequence.setLoop(0, 8);
    print("loop");
    print(tracklist.length);
    //tracklist[0].addNote(noteNumber: 48, velocity: 1, startBeat: 0, durationBeats: 1);
    //tracklist[0].addNote(noteNumber: 51, velocity: 1, startBeat: 2, durationBeats: 3);
    print("notes");
    sequence.play();
    print("play");

    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [Container(
            margin: const EdgeInsets.only(left: 5, top: 5),
            height: displayHeight -55,
            width: displayWidth * 2/3,
            child:  GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 65,
                    childAspectRatio: 1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                itemCount: 64,
                itemBuilder: (BuildContext ctx, index) {
                  return seqElements[index];
                }),
          ),
          Container(
            child:
              Column(
                children: [
                  IconButton(
                      icon: isPlaying? Icon(Icons.play_arrow, size: 35, color: Colors.green,) : Icon(Icons.play_arrow_outlined, size: 35,),
                  onPressed: (){
                  setState(() {
                      isPlaying = !isPlaying;
                      handleTogglePlayPause();
                      //print("isPlaying changed");
                    });}),


                ]
              )
          )],
        )

      ]
    );

  }
}