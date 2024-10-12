import 'package:practical_task/data/network/Baseapiservices.dart';
import 'package:practical_task/data/network/Networkapiservices.dart';
import 'package:practical_task/models/contact_list_model.dart';
import 'package:practical_task/res/components/app_url.dart';

class HomeRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<contactListModel> ContactListApi(String token)async{

    try{

      dynamic response = await _apiServices.getGetApiResponce(AppUrl.contact, token: token);
      return response = contactListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }
}