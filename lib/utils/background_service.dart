import 'dart:ui';
import 'dart:isolate';

import 'package:crestaurant2/main.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/services/restaurant_service.dart';
import 'package:crestaurant2/utils/notification_util.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationUtil notificationHelper = NotificationUtil();
    Restaurant result = await RestaurantService().fetchRandomOne();
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
