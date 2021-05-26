import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DynamicAlarmPage extends StatefulWidget {
  @override
  _DynamicAlarmPageState createState() => _DynamicAlarmPageState();
}

class _DynamicAlarmPageState extends State<DynamicAlarmPage> {
  String fromPlaceID;
  String toPlaceID;

  String fromText = 'From';
  String toText = 'To';

  var parsedDate;

  Future fromMapCall() async {
    LocationResult result = await showLocationPicker(
      context,
      'AIzaSyDMssyFpTLFdGidbTtYp5IcR4TQRTWRGuk',
      initialCenter: LatLng(30.023178, 31.446410),
      automaticallyAnimateToCurrentLocation: true,
      myLocationButtonEnabled: true,
      requiredGPS: true,
      layersButtonEnabled: true,
      countries: ['EG'],
      resultCardAlignment: Alignment.bottomCenter,
      desiredAccuracy: LocationAccuracy.best,
    );
    if (result != null) {
      fromText = 'From : ' + result.address.split(',')[0];
      fromPlaceID = result.placeId;
    }
    print("result = $result");
    setState(() {});
  }

  Future toMapCall() async {
    LocationResult result = await showLocationPicker(
      context,
      'AIzaSyDMssyFpTLFdGidbTtYp5IcR4TQRTWRGuk',
      initialCenter: LatLng(30.023178, 31.446410),
      automaticallyAnimateToCurrentLocation: true,
      myLocationButtonEnabled: true,
      requiredGPS: true,
      layersButtonEnabled: true,
      countries: ['EG'],
      resultCardAlignment: Alignment.bottomCenter,
      desiredAccuracy: LocationAccuracy.best,
    );

    toText = 'To : ' + result.address.split(',')[0];
    toPlaceID = result.placeId;

    print("result = $result");
    setState(() {});
  }

  Future<void> onPressed() async {
    //TODO: travelmode changeable

    try {
      if (parsedDate == null) throw (Exception);
      String url = Uri.encodeFull(
          "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=place_id:" +
              fromPlaceID +
              "&destinations=place_id:" +
              toPlaceID +
              "&mode=driving&departure_time=" +
              parsedDate.toString() +
              "&key=AIzaSyDMssyFpTLFdGidbTtYp5IcR4TQRTWRGuk");
      print(url);
      Uri apiurl = Uri.parse(url);
      http.Response obj = await http.get(apiurl);
      var data = jsonDecode(obj.body);
      //final DateTime = DateTime.now();

      print(data.toString());
    } catch (e) {
      toast("Some or all fields are empty or invalid");
    }
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
    );
  }

  Future<void> alarmTest() async {
    _createNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0, 'Office', 'Wakeup', DateTime.now(), platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Dynamic alarm'),
      drawer: myDrawer(context),
      body: SingleChildScrollView(
          child: Column(
        children: [
          myAddressField(context, fromText, fromMapCall),
          myAddressField(context, toText, toMapCall),
          DateTimePicker(
            type: DateTimePickerType.dateTime,
            initialValue: '',
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            dateLabelText: 'Date',
            onChanged: (val) {
              print(val.runtimeType.toString());
              parsedDate = DateTime.parse(val).millisecondsSinceEpoch;
              print(parsedDate);
            },
            validator: (val) {
              print(val.runtimeType);
              return null;
            },
            onSaved: (val) {
              print(val.runtimeType.toString());
              parsedDate = DateTime.parse(val).millisecondsSinceEpoch;
              print(parsedDate);
            },
          ),
          myButton(context, 'Calculate', onPressed),
          myButton(context, 'Alarm', alarmTest),
        ],
      )),
    );
  }
}
