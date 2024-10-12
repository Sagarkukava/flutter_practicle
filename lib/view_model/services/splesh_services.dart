
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:practical_task/models/admin_model.dart';
import 'package:practical_task/utils/routs/routes_name.dart';
import 'package:practical_task/view_model/user_view_model.dart';

import '../../res/components/Constants.dart';

class SpleshServices {

  Future<adminModel?> getUserData() => UserViewModel().getUser();

  void checkauthentication(BuildContext context) {
    getUserData().then((value) async {

      if (value == null || value.token == null) {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        print(value.user!.id.toString());
        await Future.delayed(Duration(seconds: 3));
        Constants.token = value.token.toString();
        Navigator.pushReplacementNamed(context, RoutesName.home,arguments: value);
      }
    }).onError((error, stacktrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
