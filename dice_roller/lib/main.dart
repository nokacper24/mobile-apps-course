import 'package:flutter/material.dart';
import 'package:dice_roller/gradient_container.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Application title",
      home: Scaffold(
        body: GradientContainer(
          colors: [
            Colors.blue,
            Colors.indigo,
          ],
        ),
      ),
    );
  }
}
