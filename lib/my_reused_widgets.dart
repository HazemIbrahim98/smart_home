import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

PreferredSizeWidget myAppbar(BuildContext context, String _text) {
  return AppBar(
    centerTitle: true,
    title: Text(_text),
    elevation: 0,
  );
}

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(39, 39, 39, 1),
          ),
          child: Image.asset('assets/images/logo.jpg', scale: 1.2),
        ),
        ListTile(
          title: Text('Dynamic alarm'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'Dynamic Alarm Page');
          },
        ),
        ListTile(
          title: Text('Initialize IR Module'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'Init IR Page');
          },
        ),
      ],
    ),
  );
}

Widget myButton(
    BuildContext context, String text, Function onpress, bool done) {
  Color color = done ? Colors.green : Colors.red;
  return Container(
    child: ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(primary: color, onPrimary: Colors.black),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
        ),
      ),
    ),
  );
}

void toast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}
