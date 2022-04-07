import 'package:bidu_demo/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BiduApp());
}

class BiduApp extends StatelessWidget {
  const BiduApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
