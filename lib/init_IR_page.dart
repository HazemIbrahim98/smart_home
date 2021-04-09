import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mqtt_client/mqtt_client.dart';

class InfraredPage extends StatefulWidget {
  @override
  _InfraredPageState createState() => _InfraredPageState();
}

class _InfraredPageState extends State<InfraredPage> {
  List<bool> myarr = List.filled(11, false);

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
                'Click a button and send the signal',
                textScaleFactor: 1.5,
              )),
            ),
            myButton(context, 'Power', () {
              setState(() {
                myarr[0] = true;
              });
            }, myarr[0]),
            for (int i = 1; i < 10; i++)
              myButton(context, i.toString(), () {
                setState(() {
                  myarr[i] = true;
                });
              }, myarr[i]),
            SizedBox(), //Gap to center 0
            myButton(context, '0', () {
              setState(() {
                myarr[10] = true;
              });
            }, myarr[10]),
          ],
          staggeredTiles: generateRandomTiles()),
    );
  }
}
