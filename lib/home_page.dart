import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context),
      drawer: myDrawer(context),
      body: SingleChildScrollView(child: Text('This Works my dudes!')),
    );
  }
}
