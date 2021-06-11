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
      appBar: myAppbar(context, 'Adaptive Smart Home'),
      drawer: myDrawer(context),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Center(child: Text('Welcome to Adaptive Smart Home!')),
            SizedBox(
              height: 25,
            ),
            Center(
                child:
                    Text('Where all your house needs are solved in one place')),
          ],
        ),
      )),
    );
  }
}
