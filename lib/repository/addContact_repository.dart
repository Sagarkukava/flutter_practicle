import 'package:practical_task/data/network/Baseapiservices.dart';
import 'package:practical_task/data/network/Networkapiservices.dart';
import 'package:practical_task/res/components/app_url.dart';

class AddcontactRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> AddContactApi(Map<String, dynamic> data,String token)async{

    try{

      dynamic response = await _apiServices.getPostApiResponce(AppUrl.contact, data , token: token);
      return response;
    }catch(e){
      throw e;
    }
  }

}