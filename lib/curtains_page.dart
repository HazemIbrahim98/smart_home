import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';
import 'package:smart_home/my_reused_widgets.dart';

import 'constats.dart';

class CurtainsPage extends StatefulWidget {
  @override
  _CurtainsPageState createState() => _CurtainsPageState();
}

class _CurtainsPageState extends State<CurtainsPage> {
  EzMqttClient mqttClient;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    mqttClient = EzMqttClient.nonSecure(
        url: brokerIP,
        clientId: Utils.uuid,
        enableLogs: false,
        port: brokerPORT);

    await mqttClient.connect(
        username: brokerUsername, password: brokerPassword);
  }

  void openCurtain() {
    mqttClient.publishMessage(
        topic: "Curtains/open", message: '1', qosLevel: MqttQos.exactlyOnce);
  }

  void stopCurtain() {
    mqttClient.publishMessage(
        topic: "Curtains/stop", message: '1', qosLevel: MqttQos.exactlyOnce);
  }

  void closeCurtain() {
    mqttClient.publishMessage(
        topic: "Curtains/close", message: '1', qosLevel: MqttQos.exactlyOnce);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Curtains Control'),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Control your curtains with the mobile app'),
            SizedBox(height: MediaQuery.of(context).size.height / 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myButton(context, "Open", openCurtain),
                myButton(context, "Stop", stopCurtain),
                myButton(context, "Close", closeCurtain),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
