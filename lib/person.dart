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
        url: brokerIP,
        clientId: Utils.uuid,
        enableLogs: false,
        port: brokerPORT);

    await mqttClient.connect(
        username: brokerUsername, password: brokerPassword);

    subscribe('Door/Photos');
    requestPhotos();
  }

  List<Widget> images = [];

  Future<void> subscribe(String topic) async {
    await mqttClient.subscribeToTopic(
        topic: topic,
        onMessage: (topic, message) {
          if (topic == topic) {
            if (message == 'Done')
              requestPhotos();
            else {
              message = message.replaceAll('\n', "");
              message = message.trim();

              setState(() {
                images.add(Image.memory(
                  base64Decode(message),
                  height: 250,
                  width: 250,
                ));
              });
              print(images.length);
            }
          }
        });
  }

  @override
  void initState() {
    super.initState();
    initMQTT();
  }

  void requestPhotos() {
    setState(() {
      images = [];
    });
    mqttClient.publishMessage(topic: "Door/requestPhotos", message: '1');
  }

  Widget getimages(index) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            images[index],
            myIndexedButton(context, "Approve", approvePerson, index),
            myIndexedButton(context, "Delete", deletePerson, index),
          ],
        ));
  }

  void approvePerson(int index) {
    mqttClient.publishMessage(topic: "Door/Approve", message: index.toString());
  }

  void deletePerson(int index) {
    mqttClient.publishMessage(topic: "Door/Delete", message: index.toString());
  }

  Widget buildmhthing() {
    if (images.isNotEmpty)
      return Center(
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
      );
    else
      return Center(child: Text("Horray! No unknown images detected"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppbar(context, 'Person Identifier'), body: buildmhthing());
  }
}
