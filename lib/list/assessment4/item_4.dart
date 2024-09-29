import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trial_mobile/utils/item_constant.dart';
import 'package:trial_mobile/widgets/answer_card.dart';
import 'package:trial_mobile/widgets/next_button.dart';

import '../../screens/result_screen4.dart';

class assessment4Quiz4 extends StatefulWidget {
   assessment4Quiz4({super.key});

  @override
  State<assessment4Quiz4> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<assessment4Quiz4> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = Item4questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndexItem4) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < Item4questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = Item4questions[questionIndex];
    bool isLastQuestion = questionIndex == Item4questions.length - 1;
    return Scaffold(
       appBar: AppBar(
          title: Row(
            children: [
           Text(
              'Pagsasanay 4',
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/img/assessment.png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    question.questionItem4,
                    style: GoogleFonts.fredoka(
                      textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 420,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: question.optionsItem4.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: selectedAnswerIndex == null
                              ? () => pickAnswer(index)
                              : null,
                          child: AnswerCard(
                            currentIndex: index,
                            question: question.optionsItem4[index],
                            isSelected: selectedAnswerIndex == index,
                            selectedAnswerIndex: selectedAnswerIndex,
                            correctAnswerIndex:
                                question.correctAnswerIndexItem4,
                          ),
                        );
                      },
                    ),
                  ),
                  // Next Button
                  isLastQuestion
                      ? RectangularButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => ResultScreen4(
                                  score: score,
                                ),
                              ),
                            );
                          },
                          label: 'Finish',
                        )
                      : RectangularButton(
                          onPressed: selectedAnswerIndex != null
                              ? goToNextQuestion
                              : null,
                          label: 'Next',
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
