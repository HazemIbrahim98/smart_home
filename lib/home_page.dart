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
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(39, 39, 39, 1),
            ),
            child: Image.asset('assets/images/logo.jpg', scale: 1.2),
          ),
          ListTile(
            title: Center(child: Text('Dynamic alarm')),
            onTap: () {
              Navigator.pushNamed(context, 'Dynamic Alarm Page');
            },
          ),
          ListTile(
            title: Center(child: Text('Initialize IR Module')),
            onTap: () {
              Navigator.pushNamed(context, 'Init IR Page');
            },
          ),
          ListTile(
            title: Center(child: Text('Send IR Signal')),
            onTap: () {
              Navigator.pushNamed(context, 'Send IR Page');
            },
          ),
          ListTile(
            title: Center(child: Text('Front Door')),
            onTap: () {
              Navigator.pushNamed(context, 'Door Page');
            },
          ),
          ListTile(
            title: Center(child: Text('Curtains Control')),
            onTap: () {
              Navigator.pushNamed(context, 'Curtains Page');
            },
          ),
          ListTile(
            title: Center(child: Text('Person Identifier')),
            onTap: () {
              Navigator.pushNamed(context, 'Person Page');
            },
          ),
          ListTile(
            title: Center(child: Text('Home Assistant')),
            onTap: () {
              Navigator.pushNamed(context, 'Webpage');
            },
          ),
        ],
      ),
    );
  }
}
