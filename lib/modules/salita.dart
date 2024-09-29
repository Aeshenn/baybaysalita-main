import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:trial_mobile/models/salita_model.dart';
import 'package:trial_mobile/utils/constants.dart';

class lettersPage extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();

  final int index;
  final List<SalitaData> salitaItems;
  final bool isTimerEnabled;

  lettersPage({
    Key? key,
    required this.index,
    required this.salitaItems,
    required this.isTimerEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = salitaItems[index];
    return Card(
      color: item.salitaBackgroundColor,
      child: InkWell(
        onTap: () {
          _showAnimalPopup(context, AppConstants.salitaItems[index], index);
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.salitaName,
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
              SvgPicture.asset(
                item.salitaAsset,
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

  Future<void> _showAnimalPopup(
      BuildContext context, SalitaData salita, int currentIndex) async {
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
          salita: salita,
          audioPlayer: audioPlayer,
          salitaItems: AppConstants.salitaItems,
          flutterTts: flutterTts,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _PopupDialog extends StatefulWidget {
  final List<SalitaData> salitaItems;
  int currentIndex;
  final bool isAutoNextEnabled;
  SalitaData salita;
  final AudioPlayer audioPlayer;
  final FlutterTts flutterTts;

  _PopupDialog({
    Key? key,
    required this.salitaItems,
    required this.currentIndex,
    required this.isAutoNextEnabled,
    required this.salita,
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
            color: widget.salita.salitaBackgroundColor,
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
                    _stopSalitaSound();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    _speakSalitaName(widget.salita.salitaSound);
                  },
                  icon: const Icon(Icons.volume_up),
                ),
              ]),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  widget.salita.salitaAsset,
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
                    onPressed: _navigateToPreviousSalita,
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
                      onPressed: _navigateToNextSalita,
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

  Future<void> _stopSalitaSound() async {
    await widget.audioPlayer.stop();
  }

  Future<void> _speakSalitaName(String salitaSound) async {
    await widget.audioPlayer.setAsset(salitaSound);
    await widget.audioPlayer.play();
  }

  void _navigateToPreviousSalita() {
    setState(() {
      widget.currentIndex =
          (widget.currentIndex - 1) % widget.salitaItems.length;
      if (widget.currentIndex < 0) {
        widget.currentIndex = widget.salitaItems.length - 1;
      }
      widget.salita = widget.salitaItems[widget.currentIndex];
    });
  }

  void _navigateToNextSalita() {
    setState(() {
      widget.currentIndex =
          (widget.currentIndex + 1) % widget.salitaItems.length;
      widget.salita = widget.salitaItems[widget.currentIndex];
    });
  }
}

class salitaPage extends StatefulWidget {
  salitaPage({Key? key}) : super(key: key);

  @override
  State<salitaPage> createState() => _salitaPageState();
}

class _salitaPageState extends State<salitaPage> {
  bool isTimerEnabled = false;

  List<SalitaData> items = AppConstants.salitaItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Ibat - ibang Uri Ng Mga Salita',
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
                salitaItems: items,
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
  runApp(salitaPage());
}
