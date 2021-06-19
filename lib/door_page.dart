import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:smart_home/my_reused_widgets.dart';

import 'constats.dart';

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
        url: serverIP, clientId: Utils.uuid, enableLogs: false);

    await mqttClient.connect(username: 'admin', password: 'admin');
    subscribe("Door/State");
  }

  void sendDoorState(_message) {
    mqttClient.publishMessage(
        topic: "Door/State", message: _message, qosLevel: MqttQos.exactlyOnce);
  }

  Future<void> subscribe(String topic) async {
    await mqttClient.subscribeToTopic(
        topic: topic,
        onMessage: (topic, message) {
          if (topic == "Door/State" && message == "0") {
            setState(() {
              doorOpen = false;
            });
          }
        });
  }

  void onButtonPressed() {
    setState(() {
      doorOpen = true;
    });
    sendDoorState('1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Front Door'),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Door State"),
                myDoorButton(context, doorOpen, onButtonPressed),
              ],
            ),
            Column(
              children: [
                Text("Live Door View"),
                VlcPlayer(
                  controller: _videoPlayerController,
                  aspectRatio: 16 / 9,
                  placeholder: Center(child: CircularProgressIndicator()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
