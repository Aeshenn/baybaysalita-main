import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:trial_mobile/models/abakada_model.dart';
import 'package:trial_mobile/utils/constants.dart';


class lettersPage extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();
  
    final int index;
    final List <AbakadaData> abakadaItems;
     final bool isTimerEnabled;

    lettersPage({
      Key? key,
      required this.index,
      required this.abakadaItems,
      required this.isTimerEnabled,
      })
      : super(key:key);

  @override
  Widget build(BuildContext context) {
    final item = abakadaItems[index];
    return Card(
      color: item.abakadaBG,
      child: InkWell(
        onTap: () {
          _showAnimalPopup(context, AppConstants.abakadaItems[index],index);
          
        },
         child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 3),
              SvgPicture.asset(
                item.abakadaAsset,
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 3),
            
            ],
          ),
        ),
      ),
     );
  }
   Future<void> _showAnimalPopup(BuildContext context, AbakadaData abakada, int currentIndex) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(.5);
    await flutterTts.setLanguage("EN-IN");
    await flutterTts.setPitch(1.0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _PopupDialog(
            //abakadaItems: abakadaItems,
            currentIndex: index,
            isAutoNextEnabled: isTimerEnabled,
            abakada: abakada,
            audioPlayer: audioPlayer,
            abakadaItems: AppConstants.abakadaItems,
            flutterTts: flutterTts,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _PopupDialog extends StatefulWidget {
    final List <AbakadaData> abakadaItems;
    int currentIndex;
    final bool isAutoNextEnabled;
    AbakadaData abakada;
    final AudioPlayer audioPlayer;
    final FlutterTts flutterTts;


    _PopupDialog({
      Key? key,
        required this.abakadaItems,
        required this.currentIndex,
        required this.isAutoNextEnabled,
        required this.abakada,
        required this.audioPlayer,
        required this.flutterTts,
      }) : super(key: key);

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<_PopupDialog> {
  bool isTapped = false;


  @override
  Widget build(BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  content: Container(
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        color: widget.abakada.abakadaBG,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 IconButton(
                                    onPressed: () {
                                      _stopAbakadaSound();
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                IconButton(
                                    onPressed: () {
                                      _speakAbakadaName(widget.abakada.abakadaSoundAsset);
                                    },
                                    icon: const Icon(Icons.volume_up),
                                  ),
                              ]
                            ),
                         
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                             
                            },
                            child: SvgPicture.asset(
                              widget.abakada.abakadaAsset,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                    onPressed: () {
                                      _navigateToPreviousAbakada();
                                    
                                    },
                                    icon: const Icon(Icons.arrow_circle_left, size: 35,),
                                  ),
                               IconButton(
                                    onPressed: () {
                                      _navigateToNextAbakada();
                                     
                                    },
                                    icon: const Icon(Icons.arrow_circle_right, size: 35,),
                                  ),
                            ],
                          ),
                          const SizedBox(height: 10),
                           IconButton(
                                    onPressed: () {
                                      _navigateToNextAbakada();
                                     
                                    },
                                    icon: const Icon(Icons.mic, size: 35,),
                                  ),
                          // GestureDetector(
                          //     onLongPressStart: _startRec, // start recording when long pressed
                          //     onLongPressUp: _stopRec, // stop recording when released
                          //     child: Text("Hold to record"),
                          //   );
                        ],
                      ),
                    ),
                  ),
              );
  }

  //    Future<void> _playAnimalSound(String abakadaSoundAsset) async {
  //   await widget.audioPlayer.setAsset(abakadaSoundAsset);
  //   await widget.audioPlayer.play();
  // }

  Future<void> _stopAbakadaSound() async {
    await widget.audioPlayer.stop();
  }

   Future<void> _speakAbakadaName(String abakadaSoundAsset) async {
    await widget.audioPlayer.setAsset(abakadaSoundAsset);
    await widget.audioPlayer.play();
  }
  void _navigateToPreviousAbakada() {
    setState(() {
      widget.currentIndex = (widget.currentIndex - 1) % widget.abakadaItems.length;
      if (widget.currentIndex < 0) {
        widget.currentIndex = widget.abakadaItems.length - 1;
      }
      widget.abakada = widget.abakadaItems[widget.currentIndex];
    });
  }

  void _navigateToNextAbakada() {
    setState(() {
      widget.currentIndex = (widget.currentIndex + 1) % widget.abakadaItems.length;
      widget.abakada = widget.abakadaItems[widget.currentIndex];
    });
  }

  }


class aBaKaDa extends StatefulWidget {
   aBaKaDa({Key? key}) : super(key: key);

  @override
  State<aBaKaDa> createState() => _aBaKaDaState();
}

class _aBaKaDaState extends State<aBaKaDa> {
  bool isTimerEnabled = false;

  List<AbakadaData> items = AppConstants.abakadaItems;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
             Text(
              'aBaKaDa',
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
                        image: AssetImage('lib/img/categ.png'),
                        fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width ~/
                200, // Adjust the value based on screen width
            childAspectRatio: 1.0, // Aspect ratio of items
            children: List.generate(
              items.length,
              (index) => lettersPage(
                index: index,
                abakadaItems: items,
                isTimerEnabled: isTimerEnabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp( aBaKaDa());
}
