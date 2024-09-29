import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:trial_mobile/models/things_model.dart';
import 'package:trial_mobile/utils/constants.dart';


class lettersPage extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();
  
    final int index;
    final List <Things> thingsItem;
     final bool isTimerEnabled;

    lettersPage({
      Key? key,
      required this.index,
      required this.thingsItem,
      required this.isTimerEnabled,
      })
      : super(key:key);

  @override
  Widget build(BuildContext context) {
    final item = thingsItem[index];
    return Card(
      color: item.backgroundColor,
      child: InkWell(
        onTap: () {
          _showAnimalPopup(context, AppConstants.thingsItem[index],index);
          
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
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
   Future<void> _showAnimalPopup(BuildContext context, Things things, int currentIndex) async {
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

            things: things,
            audioPlayer: audioPlayer,
            thingsItem: AppConstants.thingsItem,
            flutterTts: flutterTts,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _PopupDialog extends StatefulWidget {
    final List <Things> thingsItem;
    int currentIndex;
    final bool isAutoNextEnabled;
    Things things;
    final AudioPlayer audioPlayer;
    final FlutterTts flutterTts;


    _PopupDialog({
      Key? key,
        required this.thingsItem,
        required this.currentIndex,
        required this.isAutoNextEnabled,
        required this.things,
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
                        color: widget.things.backgroundColor,
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
                                      _stopThingsSound();
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                IconButton(
                                    onPressed: () {
                                      _speakThingsName(widget.things.soundAsset);
                                    },
                                    icon: const Icon(Icons.volume_up),
                                  ),
                              ]
                            ),
                          Text(
                           widget.things.name,
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
                              widget.things.svgAsset,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: _navigateToPreviousThings,
                                child: Text('Nakaraan',
                                style: GoogleFonts.fredoka(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ), 
                                      ),),
                              ),
                              ElevatedButton(
                                onPressed: _navigateToNextThings,
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                       Color.fromARGB(214, 27, 46, 225),
                                    ),
                                  ),
                                child: Text('Sunod',
                                style: GoogleFonts.fredoka(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ), 
                                      ),),
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
  //    Future<void> _playAnimalSound(String abakadaSoundAsset) async {
  //   await widget.audioPlayer.setAsset(abakadaSoundAsset);
  //   await widget.audioPlayer.play();
  // }

  Future<void> _stopThingsSound() async {
    await widget.audioPlayer.stop();
  }

   Future<void> _speakThingsName(String abakadaSoundAsset) async {
    await widget.audioPlayer.setAsset(abakadaSoundAsset);
    await widget.audioPlayer.play();
  }
  void _navigateToPreviousThings() {
    setState(() {
      widget.currentIndex = (widget.currentIndex - 1) % widget.thingsItem.length;
      if (widget.currentIndex < 0) {
        widget.currentIndex = widget.thingsItem.length - 1;
      }
      widget.things = widget.thingsItem[widget.currentIndex];
    });
  }

  void _navigateToNextThings() {
    setState(() {
      widget.currentIndex = (widget.currentIndex + 1) % widget.thingsItem.length;
      widget.things = widget.thingsItem[widget.currentIndex];
    });
  }

  }


class ThingsPage extends StatefulWidget {
   ThingsPage({Key? key}) : super(key: key);

  @override
  State<ThingsPage> createState() => _ThingsPageState();
}

class _ThingsPageState extends State<ThingsPage> {
  bool isTimerEnabled = false;

  List<Things> items = AppConstants.thingsItem;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Mga Uri ng Bagay',
              style: TextStyle(fontWeight: FontWeight.bold),
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
                thingsItem: items,
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
  runApp( ThingsPage());
}
