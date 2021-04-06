import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

PreferredSizeWidget myAppbar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    //backgroundColor: Colors.black,
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
      ],
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
