import 'package:flutter/material.dart';
import 'package:smart_home/constats.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';


class InfraredPage extends StatefulWidget {
  @override
  _InfraredPageState createState() => _InfraredPageState();
}

class _InfraredPageState extends State<InfraredPage> {
  List<int> myarr = List.filled(11, 0);
  bool waittingForResponse = false;
  int index;
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

    subscribe("IR/Init");
  }

  Future<void> subscribe(String topic) async {
    await mqttClient.subscribeToTopic(
        topic: topic,
        onMessage: (topic, message) {
          if (topic == 'IR/Init' && message == 'Done') {
            setState(() {
              if (index != null) myarr[index] = 2;
            });
            waittingForResponse = false;
          }
        });
  }

  bool sendIRMessage(_topic, _message) {
    if (waittingForResponse == false) {
      waittingForResponse = true;
      mqttClient.publishMessage(
          topic: _topic, message: _message, qosLevel: MqttQos.exactlyOnce);
      return true;
    }
    return false;
  }

  bool sendMQTT(_topic, _message) {
    mqttClient.publishMessage(
        topic: _topic, message: _message, qosLevel: MqttQos.exactlyOnce);
  }

  int onButtonPressed(int _index) {
    if (myarr[_index] == 0) {
      String msg = '';
      if (_index == 0)
        msg = '10';
      else if (_index == 10)
        msg = '0';
      else
        msg = _index.toString();
      if (sendIRMessage("IR/Init", msg)) {
        index = _index;
        setState(() {
          myarr[_index]++;
        });
      }
    }
    return 1;
  }

  List<StaggeredTile> generateRandomTiles() {
    List<StaggeredTile> _staggeredTiles = [];
    _staggeredTiles.add(new StaggeredTile.fit(3));
    _staggeredTiles.add(new StaggeredTile.fit(3));
    for (int i = 0; i < 11; i++) {
      _staggeredTiles.add(new StaggeredTile.fit(1));
    }
    _staggeredTiles.add(new StaggeredTile.fit(3));
    _staggeredTiles.add(new StaggeredTile.fit(3));
    return _staggeredTiles;
  }

  void save() {
    sendMQTT('IR/Save', '1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Initialize IR Module'),
      body: StaggeredGridView.count(
          padding: const EdgeInsets.only(left: 15, right: 15),
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                "Click a button to initialize/override and send a signal to the IR Module.\nDon't forget to save your preset after you're done.",
                textAlign: TextAlign.center,
              )),
            ),
            myIRInitButton(context, 'Power', myarr[0], onButtonPressed, 0),
            for (int i = 1; i < 10; i++)
              myIRInitButton(
                  context, i.toString(), myarr[i], onButtonPressed, i),
            SizedBox(), //Gap to center 0
            myIRInitButton(context, '0', myarr[10], onButtonPressed, 10),
            SizedBox(height: 50), //Gap After 0
            myButton(context, "Save", save),
          ],
          staggeredTiles: generateRandomTiles()),
    );
  }
}
