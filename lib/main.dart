import 'package:flutter/material.dart';
import 'package:calc/presentation/home.dart';

void main() {
  runApp(CalcApp());
}

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {

  bool isDark= true;
  void flipTheme(){
    setState(() {
      !isDark;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Calculator',
      theme: ThemeData(
        
        brightness: isDark ? Brightness.light : Brightness.dark
      ),
      home: CalcScreen(flipTheme),
    );
  }
}

