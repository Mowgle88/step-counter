import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Permission getMotionPermission() {
  if (Platform.isAndroid) {
    return Permission.activityRecognition;
  } else if (Platform.isIOS) {
    return Permission.sensors;
  }
  throw Error();
}

Future<void> requestPermission() async {
  final permission = getMotionPermission();

  if (await permission.isDenied) {
    await permission.request();
  }
}
