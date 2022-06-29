
import 'package:shared_preferences/shared_preferences.dart';

import 'Config.dart';

class Storage {
  static setString({
    required String name, required String field, required String value,
  }) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('$name${Config.groupSeparator}$field', value);
  }

  static setInt({
    required String name, required String field, required int value,
  }) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('$name${Config.groupSeparator}$field', value);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<int?> getInt(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(name);
  }

  static remove(String name, String field) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove('$name${Config.groupSeparator}$field');
  }

  static getKeys() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getKeys();
  }

  static clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}
