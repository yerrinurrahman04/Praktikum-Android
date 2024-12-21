import 'package:flutter/material.dart';
import 'package:quiz_app/home_screen.dart';
import 'package:quiz_app/profile.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/datas/question.dart';
import 'package:quiz_app/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  final List<String> selectedAnswer = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer.clear(); // Kosongkan daftar
      activeScreen = 'question-screen';
    });
  }

  void profileScreen() {
    setState(() {
      selectedAnswer.clear();
      activeScreen = 'profile-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = HomeScreen(
      key: const Key('home-screen'),
      startQuiz: switchScreen,
      profile: profileScreen,
    );

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectedAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        choosenAnswer: selectedAnswer,
        onRestart: restartQuiz,
      );
    }

    if (activeScreen == 'profile-screen') {
      screenWidget = const Profile();
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
