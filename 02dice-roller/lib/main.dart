import 'package:flutter/material.dart';
import 'package:project2/gradient_container.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Application title",
      home: Scaffold(
        body: GradientContainer(
          colors: const [
            Colors.blue,
            Colors.indigo,
          ],
        ),
      ),
    );
  }
}
