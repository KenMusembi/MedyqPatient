import 'package:flutter/material.dart';
import 'package:medyq_patient/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //redirects to the warrper screen
      home: Wrapper(),
    );
  }
}
