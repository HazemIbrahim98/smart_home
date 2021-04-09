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
        ListTile(
          title: Text('Display Web Page'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'Webpage');
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

Widget myAddressField(BuildContext context, String text, Function mapCall) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(
        height: 15.0,
      ),
      Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(text),
                ElevatedButton(
                  onPressed: mapCall,
                  child: Icon(Icons.map),
                )
              ],
            )),
      )
    ],
  );
}

