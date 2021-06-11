import 'package:flutter/material.dart';
import 'package:smart_home/door_page.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:smart_home/remote_page.dart';
import 'package:smart_home/webpage.dart';
import 'constats.dart';
import 'dynamic_alarm_page.dart';
import 'init_IR_page.dart';
import 'home_page.dart';

import 'package:ez_mqtt_client/ez_mqtt_client.dart';

EzMqttClient mqttClient;

void initMQTT() async {
  mqttClient = EzMqttClient.nonSecure(
      url: serverIP, clientId: Utils.uuid, enableLogs: false);

  await mqttClient.connect(username: 'admin', password: 'admin');
  subscribe('Gas');
}

Future<void> subscribe(String topic) async {
  await mqttClient.subscribeToTopic(
      topic: topic,
      onMessage: (topic, message) {
        if (topic == topic) {
          toast("GAS DETECTED In " + message);
          pushAlarm(DateTime.now(), true);
        }
      });
}

void main() {
  initMQTT();
  runApp(MyApp());
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
      },
      home: HomePage(),
    );
  }
}
