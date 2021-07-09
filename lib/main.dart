import 'package:smart_home/Door/change_password_page.dart';
import 'package:smart_home/Door/door_All_page.dart';
import 'package:smart_home/Door/door_page.dart';
import 'package:smart_home/Door/person.dart';

import 'package:smart_home/IR/remote_page.dart';
import 'package:smart_home/IR/init_IR_page.dart';
import 'package:smart_home/IR/ir_Page.dart';
import 'package:smart_home/emergency_page.dart';

import 'package:smart_home/home_page.dart';
import 'package:smart_home/curtains_page.dart';
import 'package:smart_home/dynamic_alarm_page.dart';
import 'package:smart_home/webpage.dart';

import 'package:smart_home/my_reused_widgets.dart';
import 'package:smart_home/constats.dart';

import 'package:flutter/material.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';

EzMqttClient mqttClient;

void initMQTT() async {
  try {
    mqttClient = EzMqttClient.nonSecure(
        url: brokerIP,
        clientId: Utils.uuid,
        enableLogs: false,
        port: brokerPORT);

    await mqttClient.connect(
        username: brokerUsername, password: brokerPassword);

    subscribe('Mobile/Notification');
  } catch (e) {
    print(e);
    toast("Couldn't connect to Server");
  }
}

Future<void> subscribe(String topic) async {
  await mqttClient.subscribeToTopic(
      topic: topic,
      onMessage: (topic, message) {
        if (topic == topic) {
          toast(message);
          pushAlarm(DateTime.now(), true, message);
        }
      });
}

void main() {
  runApp(MyApp());
  initMQTT();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adaptive Smart Home',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'OpenSans'),
      initialRoute: 'Language Page',
      routes: {
        'Home Page': (context) => SafeArea(child: HomePage()),
        'Dynamic Alarm Page': (context) => SafeArea(child: DynamicAlarmPage()),
        'Init IR Page': (context) => SafeArea(child: InfraredPage()),
        'Webpage': (context) => SafeArea(child: WebPage()),
        'Send IR Page': (context) => SafeArea(child: RemotePage()),
        'Door Page': (context) => SafeArea(child: DoorPage()),
        'Curtains Page': (context) => SafeArea(child: CurtainsPage()),
        'Person Page': (context) => SafeArea(child: PersonPage()),
        'IR Page': (context) => SafeArea(child: IrPage()),
        'Door All Page': (context) => SafeArea(child: DoorAllPage()),
        'Emergency Page': (context) => SafeArea(child: EmergencyPage()),
        'Change Password Page': (context) =>
            SafeArea(child: ChangePasswordPage()),
      },
      home: HomePage(),
    );
  }
}
