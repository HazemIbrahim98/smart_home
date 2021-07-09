import 'package:flutter/material.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class DoorAllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context, "Door Module"),
      body: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(39, 39, 39, 1),
            ),
            child: Image.asset('assets/images/logo.jpg', scale: 1.2),
          ),
          ListTile(
            title: Center(child: Text('View & Open')),
            onTap: () {
              Navigator.pushNamed(context, 'Door Page');
            },
          ),
          ListTile(
            title: Center(child: Text('Change Password')),
            onTap: () async {
              var localAuth = LocalAuthentication();
              try {
                bool didAuthenticate = await localAuth.authenticate(
                    localizedReason: 'Please authenticate to Access this page',
                    biometricOnly: true);
                if (didAuthenticate) {
                  toast("Approaved");
                  Navigator.pushNamed(context, 'Change Password Page');
                }
              } on PlatformException catch (e) {
                if (e.code == auth_error.lockedOut) {
                  toast(
                      "Not Approaved, Please wait 10 seconds before trying again");
                }
              }
            },
          ),
          ListTile(
            title: Center(child: Text('Person Identifier')),
            onTap: () async {
              var localAuth = LocalAuthentication();
              try {
                bool didAuthenticate = await localAuth.authenticate(
                    localizedReason: 'Please authenticate to Access this page',
                    biometricOnly: true);
                if (didAuthenticate) {
                  toast("Approaved");
                  Navigator.pushNamed(context, 'Person Page');
                }
              } on PlatformException catch (e) {
                if (e.code == auth_error.lockedOut) {
                  toast(
                      "Not Approaved, Please wait 10 seconds before trying again");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
