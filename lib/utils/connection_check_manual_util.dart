import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionCheckManual {
  Future<bool> isOffline() async {
    var connect = await Connectivity().checkConnectivity();

    if (connect != ConnectivityResult.mobile &&
        connect != ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }
}
