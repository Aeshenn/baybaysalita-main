import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trial_mobile/utils/item_constant.dart';
import 'package:trial_mobile/widgets/answer_card.dart';
import 'package:trial_mobile/widgets/next_button.dart';

import '../../screens/result_screen3.dart';

class assessment4Quiz3 extends StatefulWidget {
   assessment4Quiz3({super.key});

  @override
  State<assessment4Quiz3> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<assessment4Quiz3> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = Item3questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndexItem3) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < Item3questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = Item3questions[questionIndex];
    bool isLastQuestion = questionIndex == Item3questions.length - 1;
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
                    question.questionItem3,
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
                      itemCount: question.optionsItem3.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: selectedAnswerIndex == null
                              ? () => pickAnswer(index)
                              : null,
                          child: AnswerCard(
                            currentIndex: index,
                            question: question.optionsItem3[index],
                            isSelected: selectedAnswerIndex == index,
                            selectedAnswerIndex: selectedAnswerIndex,
                            correctAnswerIndex:
                                question.correctAnswerIndexItem3,
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
                                builder: (_) => ResultScreen3(
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
