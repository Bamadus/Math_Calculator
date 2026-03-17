import 'package:calc/logic/provider.dart';
import 'package:calc/presentation/abstract/theme_key.dart';
import 'package:flutter/material.dart';
import 'package:calc/presentation/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  Calc_provider get provider => context.watch<Calc_provider>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Calculator',
      themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: provider.isDark ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme?.fromSeed(
          seedColor: Color(0xff212529),
          brightness: provider.isDark ? Brightness.dark : Brightness.light,
          ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000)
          ),
        )
      ),
      darkTheme: ThemeData(
        brightness: provider.isDark ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme?.fromSeed(
          seedColor: Color(0xff343a40),
          brightness: provider.isDark ? Brightness.dark : Brightness.light,
          ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 25,
            fontWeight: FontWeight.w400,
            color: Color(0xffFFFFFF)
          ),
        )
      ),

      home: CalcScreen(),
    );
  }
}

