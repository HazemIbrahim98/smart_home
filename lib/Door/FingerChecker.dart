import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smart_home/my_reused_widgets.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class FingerChecker {
  static Future<bool> checkFinger(
    BuildContext context,
  ) async {
    {
      var localAuth = LocalAuthentication();
      try {
        bool checkBio = await localAuth.canCheckBiometrics;
        if (checkBio) {
          bool didAuthenticate = await localAuth.authenticate(
              localizedReason: 'Please authenticate to Access this page',
              biometricOnly: true);
          if (didAuthenticate) {
            toast("Approved");
            return true;
          }
        } else
          return true;
      } on PlatformException catch (e) {
        if (e.code == auth_error.lockedOut) {
          toast("Not Approaved, Please wait 10 seconds before trying again");
          return false;
        }
      }
    }
    return false;
  }
}
