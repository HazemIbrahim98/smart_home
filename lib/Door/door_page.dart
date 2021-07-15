import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:smart_home/constats.dart';
import 'package:smart_home/my_reused_widgets.dart';

class DoorPage extends StatefulWidget {
  @override
  _DoorPageState createState() => _DoorPageState();
}

class _DoorPageState extends State<DoorPage> {
  VlcPlayerController _videoPlayerController;
  Future<void> initializePlayer() async {}

  EzMqttClient mqttClient;
  bool doorOpen = false;
  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      rtspIP,
      hwAcc: HwAcc.FULL,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
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

    subscribe("Door/State");
  }

  void openDoor() {
    mqttClient.publishMessage(
        topic: "Door/Open", message: '1', qosLevel: MqttQos.exactlyOnce);
  }

  Future<void> subscribe(String topic) async {
    await mqttClient.subscribeToTopic(
        topic: topic,
        onMessage: (topic, message) {
          if (topic == "Door/State") {
            setState(() {
              if (message == '1')
                doorOpen = true;
              else
                doorOpen = false;
            });
          }
        });
  }

  void onButtonPressed() {
    setState(() {
      doorOpen = true;
    });
    openDoor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Front Door'),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            Column(
              children: [
                VlcPlayer(
                  controller: _videoPlayerController,
                  aspectRatio: 16 / 9,
                  placeholder: Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 10),
                Text("Live Door View"),
              ],
            ),
            SizedBox(height: 200),
            Column(
              children: [
                myDoorButton(context, doorOpen, onButtonPressed),
                Text("Open Door"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
