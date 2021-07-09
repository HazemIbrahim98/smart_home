import 'package:flutter/material.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';
import 'package:smart_home/my_reused_widgets.dart';

import 'constats.dart';

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
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

  void startEmergency() {
    mqttClient.publishMessage(topic: "Curtains/open", message: '1');
  }

  void stopEmergency() {
    mqttClient.publishMessage(topic: "Curtains/open", message: '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Emergency'),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Control your curtains with the mobile app'),
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              myButton(context, "Declare Emergency", startEmergency),
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              myButton(context, "Stop Emergency", stopEmergency),
            ],
          ),
        ),
      ),
    );
  }
}
