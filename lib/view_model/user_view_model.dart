import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:practical_task/models/admin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{

  Future<bool> saveUser(adminModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    sp.setString("user_data", userJson);
    notifyListeners();
    return true;
  }

  Future<adminModel?> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? userJson = sp.getString('user_data');

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return adminModel.fromJson(userMap);
    } else {
      return null;
    }
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("user_data");
    return true;
  }
}
