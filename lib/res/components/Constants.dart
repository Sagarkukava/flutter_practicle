
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static String token = "";

  static Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  static Future<void> saveToSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
    } catch (e) {
      print("Error saving data: $e");
    }
  }

  static Future<void> clearData() async {
    token = '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}