import 'package:expense_tracker/expense_tracker_app.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

/// Main entrypoint for the application
void main() {
  // Code commented bellow would force the app to stay in portrait mode,
  //this is not needed for this application but I keep it for future reference.

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {
  runApp(const ExpenseTrackerApp());
  // });
}
