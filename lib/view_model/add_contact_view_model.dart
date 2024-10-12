import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practical_task/repository/addContact_repository.dart';
import 'package:practical_task/utils/routs/routes_name.dart';
import 'package:practical_task/utils/utils.dart';

class AddContactViewModel with ChangeNotifier {
  final AddcontactRepository _myRepo = AddcontactRepository();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addContactApi(
      Map<String, dynamic> data, String token, BuildContext context) async {
    setLoading(true);
    try {
      final value = await _myRepo.AddContactApi(data, token);

      if (value['status'] == true) {
        Navigator.pushReplacementNamed(context, RoutesName.home);
      } else {
        Utils.flushbarErrormessage("${value['message']}", context);
        print(value['message']);
      }

      if (kDebugMode) {
        print(value.toString());
      }

    } catch (error) {
      Utils.flushbarErrormessage(error.toString(), context);

      if (kDebugMode) {
        print(error.toString());
      }
    } finally {
      setLoading(false);
    }
  }
}
