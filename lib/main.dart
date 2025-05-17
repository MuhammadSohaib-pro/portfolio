import 'package:flutter/material.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:portfolio/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sohaib',
      theme: ThemeData(
        fontFamily: 'Satoshi',
        scrollbarTheme: const ScrollbarThemeData(
          thumbColor: WidgetStatePropertyAll(AppColors.mainColor),
          thickness: WidgetStatePropertyAll(8),
          thumbVisibility: WidgetStatePropertyAll(true),
          trackVisibility: WidgetStatePropertyAll(true),
          interactive: true,
        ),
      ),
      home: HomeView(),
    );
  }
}
