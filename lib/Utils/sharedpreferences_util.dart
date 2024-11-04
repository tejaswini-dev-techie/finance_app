import 'package:hp_finance/Utils/print_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static addSharedPref(String prefKey, String? prefValue) async {
    if (prefKey.isNotEmpty && prefValue != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      PrintUtil().printMsg('addSharedPref || Key: $prefKey, Value: $prefValue');
      prefs.setString(prefKey, prefValue);
    }
  }

  static addBoolSharedPref(String prefKey, bool prefValue) async {
    // ignore: unnecessary_null_comparison
    if (prefKey.isNotEmpty && prefValue != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      PrintUtil()
          .printMsg('addBoolSharedPref || Key: $prefKey, Value: $prefValue');
      prefs.setBool(prefKey, prefValue);
    }
  }

  static Future<String?> getSharedPref(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefValue = prefs.getString(prefKey) ?? "";
    PrintUtil().printMsg('getSharedPref || Key: $prefKey, Value: $prefValue');
    return prefValue;
  }

  static Future<bool?> getBoolSharedPref(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? prefValue = prefs.getBool(prefKey) ?? false;
    PrintUtil()
        .printMsg('getBoolSharedPref || Key: $prefKey, Value: $prefValue');
    return prefValue;
  }

  static Future clearSharedPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static addIntSharedPref(String prefKey, int prefValue) async {
    if (prefKey.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      PrintUtil()
          .printMsg('addIntSharedPref || Key: $prefKey, Value: $prefValue');
      prefs.setInt(prefKey, prefValue);
    }
  }

  static Future<int?> getIntSharedPref(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? prefValue = prefs.getInt(prefKey) ?? 0;
    PrintUtil()
        .printMsg('getIntSharedPref || Key: $prefKey, Value: $prefValue');
    return prefValue;
  }

  static setListSharedPref(String prefKey, List<String> prefValue) async {
    if (prefKey.isNotEmpty && prefValue.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(prefKey, prefValue);
      PrintUtil().printMsg(
          'setListSharedPrefList || Key: $prefKey, Value: $prefValue');
    }
  }

  static Future<List<String>?> getListSharedPref(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? prefValue = prefs.getStringList(prefKey);
    PrintUtil()
        .printMsg('getSharedPrefList || Key: $prefKey, Value: $prefValue');
    return prefValue;
  }
}
