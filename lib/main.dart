import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adaptive Smart Home',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'OpenSans'),
      initialRoute: 'Language Page',
      routes: {'Home Page': (context) => SafeArea(child: HomePage())},
      home: HomePage(),
    );
  }
}
