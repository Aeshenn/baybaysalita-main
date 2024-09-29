import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:trial_mobile/models/parirala_model.dart';
import 'package:trial_mobile/utils/constants.dart';

class lettersPage extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();

  final int index;
  final List<PariralaData> pariralaItems;
  final bool isTimerEnabled;

  lettersPage({
    Key? key,
    required this.index,
    required this.pariralaItems,
    required this.isTimerEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = pariralaItems[index];
    return Container(
      child: Card(
        color: item.pariralaBackgroundColor,
        child: InkWell(
          onTap: () {
            _showAnimalPopup(context, AppConstants.pariralaItems[index], index);
          },
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.pariralaName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                // SvgPicture.asset(
                //   item.pariralaAsset,
                //   width: MediaQuery.of(context).size.width * 0.3,
                //   height: MediaQuery.of(context).size.width * 0.3,
                //   alignment: Alignment.center,
                // ),
                const SizedBox(height: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAnimalPopup(
      BuildContext context, PariralaData parirala, int currentIndex) async {
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
          parirala: parirala,
          audioPlayer: audioPlayer,
          pariralaItems: AppConstants.pariralaItems,
          flutterTts: flutterTts,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _PopupDialog extends StatefulWidget {
  final List<PariralaData> pariralaItems;
  int currentIndex;
  final bool isAutoNextEnabled;
  PariralaData parirala;
  final AudioPlayer audioPlayer;
  final FlutterTts flutterTts;

  _PopupDialog({
    Key? key,
    required this.pariralaItems,
    required this.currentIndex,
    required this.isAutoNextEnabled,
    required this.parirala,
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
            color: widget.parirala.pariralaBackgroundColor,
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                  onPressed: () {
                    _stopPariralaSound();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    _speakPariralaName(widget.parirala.pariralaSound);
                  },
                  icon: const Icon(Icons.volume_up),
                ),
              ]),
              Text(
                widget.parirala.pariralaName,
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
                onTap: () {},
                child: SvgPicture.asset(
                  widget.parirala.pariralaAsset,
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
                    onPressed: _navigateToPreviousParirala,
                    child: Text(
                      'Nakaraan',
                      style: GoogleFonts.fredoka(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: _navigateToNextParirala,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromARGB(214, 27, 46, 225),
                        ),
                      ),
                      child: Text(
                        'Sunod',
                        style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _playAnimalSound(String salitaSound) async {
  //   await widget.audioPlayer.setAsset(salitaSound);
  //   await widget.audioPlayer.play();
  // }

  Future<void> _stopPariralaSound() async {
    await widget.audioPlayer.stop();
  }

  Future<void> _speakPariralaName(String pariralaSound) async {
    await widget.audioPlayer.setAsset(pariralaSound);
    await widget.audioPlayer.play();
  }

  void _navigateToPreviousParirala() {
    setState(() {
      widget.currentIndex =
          (widget.currentIndex - 1) % widget.pariralaItems.length;
      if (widget.currentIndex < 0) {
        widget.currentIndex = widget.pariralaItems.length - 1;
      }
      widget.parirala = widget.pariralaItems[widget.currentIndex];
    });
  }

  void _navigateToNextParirala() {
    setState(() {
      widget.currentIndex =
          (widget.currentIndex + 1) % widget.pariralaItems.length;
      widget.parirala = widget.pariralaItems[widget.currentIndex];
    });
  }
}

class pariralaPage extends StatefulWidget {
  pariralaPage({Key? key}) : super(key: key);

  @override
  State<pariralaPage> createState() => _pariralaPageState();
}

class _pariralaPageState extends State<pariralaPage> {
  bool isTimerEnabled = false;

  List<PariralaData> items = AppConstants.pariralaItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Mga Parirala',
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
                image: AssetImage('lib/img/categ.png'), fit: BoxFit.fill)),
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
                pariralaItems: items,
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
  runApp(pariralaPage());
}
