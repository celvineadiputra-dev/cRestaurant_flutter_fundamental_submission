import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionCheck {
  ConnectionCheck._();

  static final _instance = ConnectionCheck._();

  static ConnectionCheck get instance => _instance;
  final _connectionCheckActivity = Connectivity();
  final _controller = StreamController.broadcast();

  Stream get connectionStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectionCheckActivity
        .checkConnectivity();

    _checkStatus(result);

    _connectionCheckActivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final res = await InternetAddress.lookup('dicoding.com');
      isOnline = res.isNotEmpty && res[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }

    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
