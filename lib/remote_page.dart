import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';

class RemotePage extends StatefulWidget {
  @override
  _RemotePageState createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> {
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
  }

  void sendIRMessage(_topic, _message) {
    mqttClient.publishMessage(
        topic: _topic, message: _message, qosLevel: MqttQos.exactlyOnce);
  }

  void onButtonPressed(int _index) {
    String msg = '';
    if (_index == 0)
      msg = '10';
    else if (_index == 10)
      msg = '0';
    else
      msg = _index.toString();
    sendIRMessage("IR/Send", msg);
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
      appBar: myAppbar(context, 'Send IR Signal'),
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
                'Click a button to send to the reciever',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              )),
            ),
            myIRSendButton(context, 'Power', onButtonPressed, 0),
            for (int i = 1; i < 10; i++)
              myIRSendButton(context, i.toString(), onButtonPressed, i),
            SizedBox(), //Gap to center 0
            myIRSendButton(context, '0', onButtonPressed, 10),
          ],
          staggeredTiles: generateRandomTiles()),
    );
  }
}
