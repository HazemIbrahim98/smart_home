import 'package:flutter/material.dart';
import 'dynamic_alarm_page.dart';
import 'init_IR_page.dart';
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
      routes: {
        'Home Page': (context) => SafeArea(child: HomePage()),
        'Dynamic Alarm Page': (context) => SafeArea(child: DynamicAlarmPage()),
        'Init IR Page': (context) => SafeArea(child: InfraredPage()),
      },
      home: HomePage(),
    );
  }
}
