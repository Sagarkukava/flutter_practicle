import 'package:practical_task/data/network/Baseapiservices.dart';
import 'package:practical_task/data/network/Networkapiservices.dart';
import 'package:practical_task/res/components/app_url.dart';

class AdminRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> LoginApi(dynamic data)async{

    try{

      dynamic response = await _apiServices.getpostApiResponce(AppUrl.login, data);
      return response;
    }catch(e){
      throw e;
    }
  }

}