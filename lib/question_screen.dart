import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/datas/question.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.onSelectedAnswer,
  });
  final void Function(String answer) onSelectedAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 215, 196, 249),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffledAnswer().map(
              (item) {
                return Container(
                    margin: const EdgeInsets.all(5),
                    child: AnswerButton(
                        text: item,
                        onTap: () {
                          answerQuestion(item);
                        },
                        ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
