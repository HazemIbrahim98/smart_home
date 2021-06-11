import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

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
  var parsedTime;

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
    try {
      if (parsedDate == null) throw (Exception);
      print(parsedDate.toString());
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
      //var data = json.decode(obj.body);
      int timeSeconds;
      try {
        Map elements = data["rows"][0];
        for (MapEntry<String, dynamic> me in elements.entries) {
          timeSeconds = me.value[0]['duration_in_traffic']['value'];
        }
      } catch (i) {
        toast(i.toString());
      }
      DateTime scheduledTime = DateTime.fromMillisecondsSinceEpoch(parsedDate);
      DateTime timez = DateFormat("HH:mm").parse(parsedTime);
      scheduledTime =
          scheduledTime.subtract(new Duration(seconds: timeSeconds));
      scheduledTime = scheduledTime
          .subtract(new Duration(hours: timez.hour, minutes: timez.minute));
      toast("Alarm Set at : " + scheduledTime.toString());
      pushAlarm(scheduledTime, false);

      print(data);
    } catch (e) {
      toast("Some or all fields are empty or invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Dynamic alarm'),
      drawer: myDrawer(context),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            myAddressField(context, fromText, fromMapCall),
            myAddressField(context, toText, toMapCall),
            DateTimePicker(
              textAlign: TextAlign.center,
              use24HourFormat: false,
              type: DateTimePickerType.dateTime,
              initialTime: TimeOfDay(hour: 0, minute: 0),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Arrival Date',
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
            DateTimePicker(
              textAlign: TextAlign.center,
              type: DateTimePickerType.time,
              initialTime: TimeOfDay(hour: 0, minute: 0),
              use24HourFormat: true,
              timeLabelText: 'Time to get ready',
              onChanged: (val) {
                print(val.runtimeType.toString());
                parsedTime = val.toString();
                DateTime timez = DateFormat("HH:mm").parse(parsedTime);

                print(timez.hour);
                print(parsedTime);
              },
              validator: (val) {
                print(val.runtimeType);
                return null;
              },
              onSaved: (val) {
                print(val.runtimeType.toString());
                parsedTime = val;
                DateTime timez = DateFormat("HH:mm").parse(parsedTime);
                print(timez.hour);
                print(parsedTime);
              },
            ),
            myButton(context, 'Calculate', onPressed),
          ],
        ),
      )),
    );
  }
}
