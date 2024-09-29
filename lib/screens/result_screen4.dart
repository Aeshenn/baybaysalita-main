import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trial_mobile/utils/item_constant.dart';
import 'package:trial_mobile/utils/routes.dart';


class ResultScreen4 extends StatelessWidget {
  const ResultScreen4({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/img/result.png'), fit: BoxFit.fill),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 365,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    value: score / 9,
                    color: Colors.red.shade400,
                    backgroundColor: const Color.fromARGB(255, 191, 188, 188),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      score.toString(),
                      style: GoogleFonts.fredoka(
                        textStyle: TextStyle(
                            fontSize: 50,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${(score / Item4questions.length * 100).round()}%',
                      style: GoogleFonts.fredoka(
                        textStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 65,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, AllRoutes.story5Item5Route);
              },
              color: Colors.red.shade400,
              padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 35), //width and height  of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "Ikasunod na Pagsusulit",
                style: GoogleFonts.fredoka(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
