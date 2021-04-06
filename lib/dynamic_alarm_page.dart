import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';

class DynamicAlarmPage extends StatefulWidget {
  @override
  _DynamicAlarmPageState createState() => _DynamicAlarmPageState();
}

class _DynamicAlarmPageState extends State<DynamicAlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Dynamic alarm'),
      drawer: myDrawer(context),
      body: SingleChildScrollView(child: Text('This Works my dudes!')),
    );
  }
}
