import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

/// A provider that exposes the list of meals.
/// This is a simple provider that returns [dummyMeals].
final mealsProvider = Provider(
  (ref) {
    return dummyMeals;
  },
);
