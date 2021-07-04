import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';

class IrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, "IR Module"),
      body: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(39, 39, 39, 1),
            ),
            child: Image.asset('assets/images/logo.jpg', scale: 1.2),
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
        ],
      ),
    );
  }
}
