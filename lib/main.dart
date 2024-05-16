import 'package:flutter/material.dart';
import 'package:stylish/homePage_v_1.0.dart';
import 'package:stylish/menu_items/HomeScreen.dart';
import 'package:stylish/special_offers_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}