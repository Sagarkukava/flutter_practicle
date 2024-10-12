
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practical_task/models/admin_model.dart';
import 'package:practical_task/repository/admin_repository.dart';
import 'package:practical_task/res/components/Constants.dart';
import 'package:practical_task/utils/routs/routes_name.dart';
import 'package:practical_task/utils/utils.dart';
import 'package:practical_task/view_model/user_view_model.dart';

class AdminViewModel with ChangeNotifier{

  final _myRepo = AdminRepository();

  bool _loding = false;
  bool get Loding => _loding;

  setloding(bool value){
    _loding = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context)async {

    setloding(true);
    _myRepo.LoginApi(data).then((value){
      print(value["status"]);
      if (value['status'] == true) {
      setloding(false);
      adminModel user = adminModel.fromJson(value);
      Constants.token = user.token.toString();
      UserViewModel().saveUser(user);
      Navigator.pushReplacementNamed(context, RoutesName.home);
      }else{
        Utils.flushbarErrormessage("${value['message'].toString()}", context);
        print(value['message'].toString());
      }
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setloding(false);
      Utils.flushbarErrormessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}