import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trial_mobile/utils/routes.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class assess2Item3 extends StatefulWidget {
  @override
  State<assess2Item3> createState() => _assess2Item3State();
}

class _assess2Item3State extends State<assess2Item3> {
  late FlutterSoundRecorder _recordingSession;
  final recordingPlayer = AssetsAudioPlayer();
  late String pathToAudio;
  bool _isRecording = false;
  bool _isPlaying = false;
  String _timerText = '00:00:00';
  StreamSubscription? _recorderSubscription;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _recordingSession.closeAudioSession();
    recordingPlayer.dispose();
    super.dispose();
  }

  Future<void> initialize() async {
    pathToAudio = '/E:/temp.wav'; // Adjust the path as per your requirement

    // Initialize FlutterSoundRecorder
    _recordingSession = FlutterSoundRecorder();

    // Request necessary permissions
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();

    // Initialize audio session
    await _recordingSession.openAudioSession(
      focus: AudioFocus.requestFocusAndStopOthers,
      category: SessionCategory.playAndRecord,
      mode: SessionMode.modeDefault,
      device: AudioDevice.speaker,
    );
    await _recordingSession.setSubscriptionDuration(Duration(milliseconds: 10));

    // Initialize date formatting (if needed)
    await initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: Row(
            children: [
           Text(
              'Pagsasanay 2',
              style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                        fontWeight: FontWeight.w600,
                    ), 
                    ),
            ),
            ],
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/img/assessment.png'),
                  fit: BoxFit.fill),
            ),
            alignment: Alignment.center,
            child: Column(children: [
              SizedBox(
                height: 25,
              ),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("lib/img/logo.png"))),
              ),
              Container(
                height: 390,
                width: 450,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color(0xFF004380),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Ano ang tunog ng aso?',
                        style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 100),
                    Text(
                      _timerText,
                      style: TextStyle(fontSize: 50, color: Colors.red),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        createElevatedButton(
                          icon: Icons.mic,
                          iconColor: Colors.red,
                          label: _isRecording ? 'Recording...' : 'Record',
                          onPressFunc: _isRecording ? null: startRecording,
                        ),
                        SizedBox(width: 30),
                        createElevatedButton(
                          icon: Icons.stop,
                          iconColor: Colors.red,
                          label: 'Stop',
                          onPressFunc: _isRecording ? stopRecording : null,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // ElevatedButton.icon(
                    //   style: ElevatedButton.styleFrom(
                    //     elevation: 9.0,
                    //     backgroundColor: Colors.red,
                    //   ),
                    //   onPressed: _isPlaying ? stopPlayFunc : playFunc,
                    //   icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                    //   label: Text(_isPlaying ? 'Stop Playback' : 'Play'),
                    // ),
                    createElevatedButtonPlayStop(
                      icon: _isPlaying ? Icons.stop : Icons.play_arrow,
                      iconColor: Colors.white,
                      label: _isPlaying ? 'Stop Playback' : 'Play',
                      onPressFunc: _isPlaying ? stopPlayFunc : playFunc,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AllRoutes.assess2Item4Route);
                  },
                  color: Color(0xfff5505b),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 130),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    "Sunod",
                    style: GoogleFonts.fredoka(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ]
            )
            )
            );
  }
  ElevatedButton createElevatedButton({
    required IconData icon,
    required Color iconColor,
    required String label,
    VoidCallback? onPressFunc,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(6.0),
        side: BorderSide(color: Colors.red, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize:  Size(125, 40),
        backgroundColor: Colors.white,
        //elevation: 9.0,
      ),
      onPressed: onPressFunc,
      icon: Icon(icon, color: iconColor, size: 25.0),
      label: Text(label, style: TextStyle(fontSize: 18, color: Colors.black)),
    );
  }
  ElevatedButton createElevatedButtonPlayStop({
    required IconData icon,
    required Color iconColor,
    required String label,
    VoidCallback? onPressFunc,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(6.0),
        side: BorderSide(color: Colors.blue.shade400, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
         minimumSize:  Size(125, 40),
        backgroundColor: Colors.blue.shade400,
        //elevation: 9.0,
      ),
      onPressed: onPressFunc,
      icon: Icon(icon, color: iconColor, size: 25.0),
      label: Text(label, style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  Future<void> startRecording() async {
    Directory directory = Directory(path.dirname(pathToAudio));
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    _recordingSession.openAudioSession();
    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );

    _recorderSubscription = _recordingSession.onProgress?.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(
        e.duration.inMilliseconds,
        isUtc: true,
      );
      var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _timerText = timeText.substring(0, 8);
      });
    });
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> stopRecording() async {
    await _recordingSession.stopRecorder();
    _recorderSubscription?.cancel();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> playFunc() async {
    await recordingPlayer.open(
      Audio.file(pathToAudio),
      autoStart: true,
      showNotification: true,
    );
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> stopPlayFunc() async {
    await recordingPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }
}

