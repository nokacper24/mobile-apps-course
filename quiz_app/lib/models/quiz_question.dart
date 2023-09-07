class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion(this.text, this.answers);

  List<String> getShuffledANswers() {
    List<String> copy = List.of(answers);
    copy.shuffle();
    return copy;
  }
}
