import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

PreferredSizeWidget myAppbar(BuildContext context, String _text) {
  return AppBar(
    centerTitle: true,
    title: Text(_text),
    elevation: 0,
  );
}

Widget myButton(BuildContext context, String text, Function onpress) {
  return Container(
    child: ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
          primary: Colors.green, onPrimary: Colors.black),
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

Widget myIndexedButton(
    BuildContext context, String text, Function onpress, int parameters) {
  return Container(
    child: ElevatedButton(
      onPressed: () => {onpress(parameters)},
      style: ElevatedButton.styleFrom(
          primary: Colors.green, onPrimary: Colors.black),
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

Widget myIRInitButton(BuildContext context, String text, int state,
    Function(int) onpress, int index) {
  Color color;
  if (state == 0)
    color = Colors.red;
  else if (state == 1)
    color = Colors.yellow;
  else
    color = Colors.green;
  if (text == 'Power')
    return Container(
      child: ElevatedButton(
          onPressed: () {
            onpress(index);
          },
          style:
              ElevatedButton.styleFrom(primary: color, onPrimary: Colors.black),
          child: Icon(Icons.power_settings_new)),
    );
  else
    return Container(
      child: ElevatedButton(
        onPressed: () {
          onpress(index);
        },
        style:
            ElevatedButton.styleFrom(primary: color, onPrimary: Colors.black),
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

Widget myDoorButton(BuildContext context, bool state, Function onpress) {
  Color color;
  if (state)
    color = Colors.green;
  else
    color = Colors.red;

  return Container(
    child: ElevatedButton(
        onPressed: onpress,
        style:
            ElevatedButton.styleFrom(primary: color, onPrimary: Colors.black),
        child: Icon(Icons.power_settings_new)),
  );
}

Widget myIRSendButton(
    BuildContext context, String text, Function(int) onpress, int index) {
  if (text == 'Power')
    return Container(
      child: ElevatedButton(
          onPressed: () {
            onpress(index);
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.green, onPrimary: Colors.black),
          child: Icon(Icons.power_settings_new)),
    );
  else
    return Container(
      child: ElevatedButton(
        onPressed: () {
          onpress(index);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.green, onPrimary: Colors.black),
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

void pushAlarm(DateTime scheduledTime, bool alarm) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (alarm) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notify',
      'alarm_notify',
      'Channel for Alarm notification',
      importance: Importance.max,
      icon: 'alert',
      sound: RawResourceAndroidNotificationSound('alert'),
      largeIcon: DrawableResourceAndroidBitmap('alert'),
    );
    print(alarm);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'alert.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0, 'WARNING!', 'Gas Detected', scheduledTime, platformChannelSpecifics);
  } else {
    print("got here");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      importance: Importance.high,
      icon: 'logo_black',
      sound: RawResourceAndroidNotificationSound('alarm'),
      largeIcon: DrawableResourceAndroidBitmap('logo_black'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'alarm.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0, 'Alarm', 'Good Morning :)', scheduledTime, platformChannelSpecifics);
  }
}
