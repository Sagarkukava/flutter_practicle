import 'package:flutter/cupertino.dart';
import 'package:practical_task/data/response/api_responce.dart';
import 'package:practical_task/models/contact_details_model.dart';
import 'package:practical_task/repository/contactDetails_repository.dart';
import 'package:practical_task/utils/utils.dart';

class ContactDetailsViewModel with ChangeNotifier{

  final _myRepo = ContactdetailsRepository();

  ApiResponce<ContactDetailsModel> contactdetails = ApiResponce.loding();

  setContactDetails(ApiResponce<ContactDetailsModel> response){
    contactdetails = response;
    notifyListeners();
  }

  Future<void> ContactDetailsApi(String token,String id, BuildContext context) async{

    setContactDetails(ApiResponce.loding());
    _myRepo.ContactDetailsApi(token,id).then((value){

      if(value.status == true){
        print(value.data);
        setContactDetails(ApiResponce.complated(value));
      }else{
        Utils.flushbarErrormessage("${value.message.toString()}", context);
      }

    }).onError((error, stackTrace){
      setContactDetails(ApiResponce.error(error.toString()));
    });
  }
}