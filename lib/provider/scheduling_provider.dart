import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:crestaurant2/utils/background_service.dart';
import 'package:crestaurant2/utils/date_time_util.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  SchedulingProvider() {
    initScheduling();
  }

  void initScheduling() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _isScheduled = pref.getBool('isScheduled') ?? false;
    notifyListeners();
  }

  Future<bool> scheduledRandom(bool value) async {
    _isScheduled = value;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isScheduled', _isScheduled);
    if (_isScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeUtil.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}