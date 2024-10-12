import 'package:practical_task/data/network/Baseapiservices.dart';
import 'package:practical_task/data/network/Networkapiservices.dart';
import 'package:practical_task/models/contact_details_model.dart';
import 'package:practical_task/res/components/app_url.dart';

class ContactdetailsRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<ContactDetailsModel> ContactDetailsApi(String token,String id)async{

    try{
      String url = '${AppUrl.contact}/$id';
      dynamic response = await _apiServices.getGetApiResponce(url, token: token);
      return response = ContactDetailsModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }
}