// import 'package:bidu_demo/presentation/screen/home_screen.dart';
import 'package:bidu_demo/presentation/screen/home_screen.dart' as refactor;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const BiduApp());
}

class BiduApp extends StatelessWidget {
  const BiduApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const refactor.HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(accentColor: Colors.grey),
        fontFamily: 'Lexend',
        // textButtonTheme:
      ),
    );
  }
}
