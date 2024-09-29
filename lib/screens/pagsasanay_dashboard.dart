import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trial_mobile/utils/routes.dart';

// ignore: must_be_immutable
class PagsasanayDashPage extends StatelessWidget {
  PagsasanayDashPage({super.key});

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '',
                style: GoogleFonts.fredoka(
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: Color(0xffa459d1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:  SingleChildScrollView(
          child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/img/categ.png'),
                          fit: BoxFit.fill)),
                  child: Column(
                    children: [
                    Container(
                      decoration: BoxDecoration(),
                      height: height * 0.25,
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 350,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("lib/img/logo.png"))),
                          ),
                        ],
                      ),
                    ),
                   SingleChildScrollView(
                     child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('lib/img/category-dash.png'),
                                fit: BoxFit.fill),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                        height: 670,
                        width: width,
                        padding: EdgeInsets.only(
                          bottom: 20,
                          top: 10,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage('lib/img/letters/Assessment1.png'),
                                        fit: BoxFit.fill),
                                    color: Color.fromARGB(255, 249, 242, 224)),
                                height: 150,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.transparent),
                                      shadowColor: WidgetStateProperty.all<Color>(
                                          Colors.transparent),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      minimumSize:
                                          WidgetStateProperty.all(Size(450, 150))),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AllRoutes.assess1Item1Route);
                                  },
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage('lib/img/letters/Assessment2.png'),
                                        fit: BoxFit.fill),
                                    color: Color.fromARGB(255, 249, 242, 224)),
                                height: 150,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.transparent),
                                      shadowColor: WidgetStateProperty.all<Color>(
                                          Colors.transparent),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      minimumSize:
                                          WidgetStateProperty.all(Size(450, 150))),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AllRoutes.assess2Item1Route);
                                  },
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage('lib/img/letters/Assessment3.png'),
                                        fit: BoxFit.fill),
                                    color: Color.fromARGB(255, 249, 242, 224)),
                                height: 150,
                              
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.transparent),
                                      shadowColor: WidgetStateProperty.all<Color>(
                                          Colors.transparent),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      minimumSize:
                                          WidgetStateProperty.all(Size(450, 150))),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AllRoutes.assess3Item1Route);
                                  },
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                   
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage('lib/img/letters/Assessment4.png'),
                                        fit: BoxFit.fill),
                                    color: Color.fromARGB(255, 249, 242, 224)),
                                height: 150,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.transparent),
                                      shadowColor: WidgetStateProperty.all<Color>(
                                          Colors.transparent),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      minimumSize:
                                          WidgetStateProperty.all(Size(450, 150))),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AllRoutes.story1Item1Route);
                                  },
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                   )
                   ]
                   )
                  ),
        )
        );
  }
}
