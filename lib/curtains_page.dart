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
        url: serverIP, clientId: Utils.uuid, enableLogs: false);

    await mqttClient.connect(username: 'admin', password: 'admin');
  }

  void openCurtain() {
    mqttClient.publishMessage(
        topic: "Curtains/open", message: '', qosLevel: MqttQos.exactlyOnce);
  }

  void stopCurtain() {
    mqttClient.publishMessage(
        topic: "Curtains/stop", message: '', qosLevel: MqttQos.exactlyOnce);
  }

  void closeCurtain() {
    mqttClient.publishMessage(
        topic: "Curtains/close", message: '', qosLevel: MqttQos.exactlyOnce);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Curtains Control'),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myButton(context, "Open", openCurtain),
              myButton(context, "Stop", stopCurtain),
              myButton(context, "Close", closeCurtain),
            ],
          ),
        ),
      ),
    );
  }
}
