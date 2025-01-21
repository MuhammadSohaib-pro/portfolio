import 'package:flutter/material.dart';
import 'package:portfolio/res/mySize.dart';
import 'package:portfolio/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M. Sohaib | Flutter Developer',
      theme: ThemeData(
        fontFamily: 'Satoshi',
      ),
      home: HomeView(),
    );
  }
}
