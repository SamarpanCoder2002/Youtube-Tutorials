import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManagement {
  static storeData(int latestNumber) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setInt('number', latestNumber);
  }

  static Future<int?> getData() async {
    final _instance = await SharedPreferences.getInstance();
    final _latestNumber = _instance.getInt('number');

    return _latestNumber;
  }
}
