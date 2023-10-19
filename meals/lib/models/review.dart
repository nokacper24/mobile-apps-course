class Review {
  final String id;
  final Rating rating;

  Review({required this.id, required this.rating});
}

enum Rating { poor, average, good, veryGood, excellent }
