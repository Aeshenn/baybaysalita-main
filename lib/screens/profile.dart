import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Row(
          children: [
            Text(
              'Profile',
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/img/categ.png'), fit: BoxFit.fill)),
          padding: EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 350,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Stack(fit: StackFit.expand, children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              Text('Krystal Almazan',
                                  style: GoogleFonts.fredoka(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  )),
                              Text(
                                '122334345567',
                                style: GoogleFonts.fredoka(
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black.withOpacity(.3),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Grade',
                                        style: GoogleFonts.fredoka(
                                          textStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '1',
                                        style: GoogleFonts.fredoka(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 38),
                                    child: Container(
                                      height: 40,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Section',
                                        style: GoogleFonts.fredoka(
                                          textStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'INF211',
                                        style: GoogleFonts.fredoka(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                              width: 150,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('lib/img/letters/student.jpg'),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xfff5505b).withOpacity(.5),
                                    width: 5.0,
                                  ))),
                        ),
                      ),
                    ]);
                  }),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: height * 0.4,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Progress',
                        style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text(
                              'Pagbaybay',
                              style: GoogleFonts.fredoka(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 350,
                            child: GFProgressBar(
                              percentage: 0.7,
                              lineHeight: 30,
                              alignment: MainAxisAlignment.spaceBetween,
                              leading: Icon(Icons.sentiment_dissatisfied,
                                  color: Color.fromARGB(255, 237, 20, 5)),
                              trailing: Icon(Icons.sentiment_satisfied,
                                  color: Color.fromARGB(255, 27, 171, 31)),
                              backgroundColor:
                                  const Color.fromARGB(31, 0, 0, 0),
                              progressBarColor:
                                  const Color.fromARGB(255, 116, 62, 193),
                              child: Text(
                                '70%',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.fredoka(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(.3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Text(
                              'Pagbasa',
                              style: GoogleFonts.fredoka(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 350,
                            child: GFProgressBar(
                              percentage: 0.7,
                              lineHeight: 30,
                              alignment: MainAxisAlignment.spaceBetween,
                              leading: Icon(Icons.sentiment_dissatisfied,
                                  color: Color.fromARGB(255, 237, 20, 5)),
                              trailing: Icon(Icons.sentiment_satisfied,
                                  color: Color.fromARGB(255, 27, 171, 31)),
                              backgroundColor:
                                  const Color.fromARGB(31, 0, 0, 0),
                              progressBarColor: Color(0xfff5505b),
                              child: Text(
                                '70%',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.fredoka(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(.3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
