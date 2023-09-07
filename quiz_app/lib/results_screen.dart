import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';

class ResultsScreen extends StatelessWidget {
  final List<String> chosenAnswers;
  final void Function() resetFunction;

  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.resetFunction,
  });

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('You answered out of questions correctly!'),
          const SizedBox(
            height: 30,
          ),
          const Text('List of answers and questions...'),
          const SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: resetFunction, child: const Text('Restart Quiz'))
        ],
      ),
    );
  }
}
