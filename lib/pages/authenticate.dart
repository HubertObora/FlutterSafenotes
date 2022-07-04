import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> authenticateIsAvailable() async {
    final isAvailable = await auth.canCheckBiometrics;
    final isDeviceSupported = await auth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  static Future<bool> authenticate() async {
    final isAvailable = await authenticateIsAvailable();
    if (!isAvailable) return false;
    try {
      return await auth.authenticate(
          localizedReason:
              'Zeskanuj odcisk palca lub wpisz kod PIN aby zobaczyć chronione notatki',
          options: const AuthenticationOptions(
            biometricOnly: false,
            useErrorDialogs: true,
          ));
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
