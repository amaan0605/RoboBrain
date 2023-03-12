import 'package:ai_magic/screens/home.dart';
import 'package:ai_magic/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: backgroundColor),
          scaffoldBackgroundColor: botBackgroundColor,
          fontFamily: 'NunitoSans'),
      home: const HomePage(),
    );
  }
}
