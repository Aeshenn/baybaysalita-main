import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:trial_mobile/models/hayop_model.dart';
import 'package:trial_mobile/utils/constants.dart';


class lettersPage extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();
  
    final int index;
    final List <Hayop> animalsItem;
     final bool isTimerEnabled;

    lettersPage({
      Key? key,
      required this.index,
      required this.animalsItem,
      required this.isTimerEnabled,
      })
      : super(key:key);

  @override
  Widget build(BuildContext context) {
    final item = animalsItem[index];
    return Card(
      color: item.backgroundColor,
      child: InkWell(
        onTap: () {
          _showAnimalPopup(context, AppConstants.animalsItem[index],index);
          
        },
         child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.name,
                 style: GoogleFonts.fredoka(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                            fontWeight: FontWeight.w500,
                        ), 
                                  ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              SvgPicture.asset(
                item.svgAsset,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 3),
              
            ],
          ),
        ),
      ),
     );
  }
   Future<void> _showAnimalPopup(BuildContext context, Hayop animals, int currentIndex) async {
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

            animal: animals,
            audioPlayer: audioPlayer,
            animalsItem: AppConstants.animalsItem,
            flutterTts: flutterTts,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _PopupDialog extends StatefulWidget {
    final List <Hayop> animalsItem;
    int currentIndex;
    final bool isAutoNextEnabled;
    Hayop animal;
    final AudioPlayer audioPlayer;
    final FlutterTts flutterTts;


    _PopupDialog({
      Key? key,
        required this.animalsItem,
        required this.currentIndex,
        required this.isAutoNextEnabled,
        required this.animal,
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
                        color: widget.animal.backgroundColor,
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
                                      _stopAnimalSound();
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _speakAbakadaName(widget.animal.speechAsset);
                                    },
                                    icon: const Icon(Icons.volume_up),
                                  ),
                              ]
                            ),
                          Text(
                           widget.animal.name,
                           style: GoogleFonts.fredoka(
                                  textStyle: TextStyle(
                                    fontSize: 40,
                                    color: Colors.black,
                                     fontWeight: FontWeight.w500,
                                  ), 
                                  ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                            },
                            child: SvgPicture.asset(
                              widget.animal.svgAsset,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              alignment: Alignment.center,
                            ),
                          ),
                        
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _playAnimalSound(widget.animal.soundAsset);
                            },
                            child: Text(
                              'Tunog ng Hayop',
                               style: GoogleFonts.fredoka(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                     fontWeight: FontWeight.w500,
                                  ), 
                                  ),
                                ),
                          ),
                            const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: _navigateToPreviousAnimal,
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                       Color.fromARGB(215, 255, 255, 255),
                                    ),
                                  ),
                                child:  Text('Nakaraan',
                               style: GoogleFonts.fredoka(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ), 
                                      ),
                                )
                              ),
                              ElevatedButton(
                                onPressed: _navigateToNextAnimal,
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                       Color.fromARGB(214, 27, 46, 225),
                                    ),
                                  ),
                               child:  Text('Sunod',
                               style: GoogleFonts.fredoka(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ), 
                                      ),
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
              );
  }
     Future<void> _playAnimalSound(String soundAsset) async {
    await widget.audioPlayer.setAsset(soundAsset);
    await widget.audioPlayer.play();
  }

  Future<void> _stopAnimalSound() async {
    await widget.audioPlayer.stop();
  }

   Future<void> _speakAbakadaName(String speechAsset) async {
    await widget.audioPlayer.setAsset(speechAsset);
    await widget.audioPlayer.play();
  }
  void _navigateToPreviousAnimal() {
    setState(() {
      widget.currentIndex = (widget.currentIndex - 1) % widget.animalsItem.length;
      if (widget.currentIndex < 0) {
        widget.currentIndex = widget.animalsItem.length - 1;
      }
      widget.animal = widget.animalsItem[widget.currentIndex];
    });
  }

  void _navigateToNextAnimal() {
    setState(() {
      widget.currentIndex = (widget.currentIndex + 1) % widget.animalsItem.length;
      widget.animal = widget.animalsItem[widget.currentIndex];
    });
  }

  }


class hayop extends StatefulWidget {
   hayop ({Key? key}) : super(key: key);

  @override
  State<hayop> createState() => _HayopState();
}

class _HayopState extends State<hayop> {
  bool isTimerEnabled = false;

  List<Hayop> items = AppConstants.animalsItem;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
             Text(
              'Mga Uri ng Hayop',
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
          padding:  EdgeInsets.all(9),
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width ~/
                200, // Adjust the value based on screen width
            childAspectRatio: 1.0, // Aspect ratio of items
            children: List.generate(
              items.length,
              (index) => lettersPage(
                index: index,
                animalsItem: items,
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
  runApp( hayop());
}
