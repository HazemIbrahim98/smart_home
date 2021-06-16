import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';

import 'constats.dart';

EzMqttClient mqttClient;

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  void initMQTT() async {
    mqttClient = EzMqttClient.nonSecure(
        url: serverIP, clientId: Utils.uuid, enableLogs: false);

    await mqttClient.connect(username: 'admin', password: 'admin');
    subscribe('Door/Photos');
  }

  List<Widget> images = [];

  Future<void> subscribe(String topic) async {
    await mqttClient.subscribeToTopic(
        topic: topic,
        onMessage: (topic, message) {
          if (topic == topic) {
            message = message.replaceAll('\n', "");
            message = message.trim();

            setState(() {
              images.add(Image.memory(
                base64Decode(message),
                height: 250,
                width: 250,
              ));
            });
          }
        });
  }

  @override
  void initState() {
    super.initState();
    initMQTT();
    requestPhotos();
  }

  void requestPhotos() {
    images = [];
    mqttClient.publishMessage(topic: "Door/requestPhotos", message: '1');
  }

  Widget getimages(index) {
    if (images.isNotEmpty)
      return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              images[index],
              myIndexedButton(context, "Approve", approvePerson, index),
              myIndexedButton(context, "Delete", deletePerson, index),
            ],
          ));
    return SizedBox();
  }

  void approvePerson(int index) {
    mqttClient.publishMessage(topic: "Door/Approve", message: index.toString());
    requestPhotos();
  }

  void deletePerson(int index) {
    mqttClient.publishMessage(topic: "Door/Delete", message: index.toString());
    requestPhotos();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Person Identifier'),
      drawer: myDrawer(context),
      body: Center(
        child: ListView(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.5),
          shrinkWrap: true,
          physics: PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            for (var i = 0; i < images.length; i++) Center(child: getimages(i)),
          ],
        ),
      ),
    );
  }
}
