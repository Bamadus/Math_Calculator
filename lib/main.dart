import 'package:calc/logic/provider.dart';
import 'package:flutter/material.dart';
import 'package:calc/presentation/home.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(
    ChangeNotifierProvider(
      create: (_)=> Calc_provider(),
      child: const CalcApp(),
    ));
}

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {

  bool isDark = false;
  void flipTheme(){
    setState(() {
      isDark = !isDark;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Calculator',
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme?.fromSeed(
          seedColor: Color(0xff212529),
          brightness: isDark ? Brightness.dark : Brightness.light,
          ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000)
          ),
        )
      ),
      darkTheme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme?.fromSeed(
          seedColor: Color(0xff343a40),
          brightness: isDark ? Brightness.dark : Brightness.light,
          ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 25,
            fontWeight: FontWeight.w400,
            color: Color(0xffFFFFFF)
          ),
        )
      ),

      home: CalcScreen(flipTheme),
    );
  }
}

