import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbClient {
  setData(String key, String value) async {
    final  prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
   Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all data
    print('All data cleared');
  }

  resetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
final dbClientprovider = Provider<DbClient>((ref) {
  return DbClient();
});

