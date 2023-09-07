import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() {
    return _QuizAppState();
  }
}

class _QuizAppState extends State<QuizApp> {
  late Widget currentScreen;
  // Widget? currentScreen;
  final List<String> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    currentScreen = StartScreen(startQuiz: startQuiz);
  }

  void addAnswer(String selectedAnswer) {
    selectedAnswers.add(selectedAnswer);
    if (selectedAnswers.length >= questions.length) {
      switchScreen(ResultsScreen(
        chosenAnswers: selectedAnswers,
        onReset: resetQuiz,
        onHome: resetAndHome,
      ));
    }
  }

  void switchScreen(Widget screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  void resetQuiz() {
    selectedAnswers.clear();
    switchScreen(QuestionScreen(onSelectAnswer: addAnswer));
  }

  void resetAndHome() {
    selectedAnswers.clear();
    switchScreen(StartScreen(startQuiz: startQuiz));
  }

  void startQuiz() {
    switchScreen(QuestionScreen(onSelectAnswer: addAnswer));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz App",
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 55, 20, 120),
                Color.fromARGB(255, 50, 18, 115)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: currentScreen,
        ),
      ),
    );
  }
}
