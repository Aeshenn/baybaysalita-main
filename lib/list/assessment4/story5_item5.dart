import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trial_mobile/utils/routes.dart';

// ignore: must_be_immutable
class Story5Item5Page extends StatelessWidget {
  Story5Item5Page({super.key});

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
                  image: AssetImage('lib/img/assessment.png'), fit: BoxFit.fill),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
              SizedBox(height: 25,),
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
                    Text(
                      'Umay sayo',
                      style: GoogleFonts.fredoka(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'May regalo si Nilda. Ang regalo niya ay nasa kahon. Binuksa niya ang kahon. May laman itong bag. Ito ay yari sa abaka. ',
                        style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AllRoutes.quiz5Route);
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
            ])));
  }
}
