import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:http/http.dart' as http;

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  Future<void> ThisisTest() async {
    var url = Uri.parse('//192.168.1.10/images/backpackman.jpg');
    try {
      var response = await http.get(url);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    ThisisTest();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, 'Initialize IR Module'),
      drawer: myDrawer(context),
    );
  }
}
