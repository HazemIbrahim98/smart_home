import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';

class DoorAllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, "Door Module"),
      body: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(39, 39, 39, 1),
            ),
            child: Image.asset('assets/images/logo.jpg', scale: 1.2),
          ),
          ListTile(
            title: Center(child: Text('View & Open')),
            onTap: () {
              Navigator.pushNamed(context, 'Door Page');
            },
          ),
          ListTile(
              title: Center(child: Text('Change Password')),
              onTap: () {
                Navigator.pushNamed(context, 'Change Password Page');
              }),
          ListTile(
              title: Center(child: Text('Person Identifier')),
              onTap: () {
                Navigator.pushNamed(context, 'Person Page');
              }),
        ],
      ),
    );
  }
}
