import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/constats.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPage createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  final TextEditingController passwordController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppbar(context, "Change Password"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(height: 50),
                TextFormField(
                  controller: passwordController,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: 'New Password'),
                ),
                SizedBox(height: 50),
                myButton(context, 'Change Password', checkPassword),
              ],
            ),
          ),
        ));
  }

  void checkPassword() {
    try {
      int.parse(passwordController.text);
      if (passwordController.text.length != 4) throw Exception();
      toast(passwordController.text);
      changePassword(passwordController.text);
    } catch (e) {
      toast("Please Enter A 4 degit Number");
    }
  }

  void changePassword(String password) {
    mqttClient.publishMessage(
        topic: "Door/Password",
        message: password,
        qosLevel: MqttQos.exactlyOnce);
  }
}
