import 'package:flutter/material.dart';
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
        url: '192.168.1.109', clientId: Utils.uuid, enableLogs: true);

    await mqttClient.connect(username: 'admin', password: 'admin');
    subscribe("IR/Init");
  }

  Future<void> sendMessages(String topic, String message) async {
    mqttClient.publishMessage(
        topic: topic, message: message, qosLevel: MqttQos.exactlyOnce);
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
      sendMessages(_topic, _message);
      return true;
    }
    return false;
  }

  List<StaggeredTile> generateRandomTiles() {
    List<StaggeredTile> _staggeredTiles = [];
    _staggeredTiles.add(new StaggeredTile.fit(3));
    _staggeredTiles.add(new StaggeredTile.fit(3));
    for (int i = 0; i < 11; i++) {
      _staggeredTiles.add(new StaggeredTile.fit(1));
    }

    return _staggeredTiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Initialize IR Module'),
      drawer: myDrawer(context),
      body: StaggeredGridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                'Click a button and send the corresponding signal to the IR Module',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              )),
            ),
            myIRButton(context, 'Power', () {
              if (myarr[0] == 0) {
                if (sendIRMessage("IR/Init", "Power")) {
                  index = 0;
                  setState(() {
                    myarr[0]++;
                  });
                }
              }
            }, myarr[0]),
            for (int i = 1; i < 10; i++)
              myIRButton(context, i.toString(), () {
                if (myarr[i] == 0) {
                  if (sendIRMessage("IR/Init", i.toString())) {
                    index = i;
                    setState(() {
                      myarr[i]++;
                    });
                  }
                }
              }, myarr[i]),
            SizedBox(), //Gap to center 0
            myIRButton(context, '0', () {
              if (myarr[10] == 0) {
                if (sendIRMessage("IR/Init", '0')) {
                  index = 10;
                  setState(() {
                    myarr[10]++;
                  });
                }
              }
            }, myarr[10]),
          ],
          staggeredTiles: generateRandomTiles()),
    );
  }
}
