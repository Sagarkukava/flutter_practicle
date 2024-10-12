import 'package:flutter/cupertino.dart';
import 'package:practical_task/data/response/api_responce.dart';
import 'package:practical_task/models/contact_list_model.dart';
import 'package:practical_task/repository/home_repository.dart';
import 'package:practical_task/utils/utils.dart';

class HomeViewModel with ChangeNotifier{

  final _myRepo = HomeRepository();

  ApiResponce<contactListModel> contactlist = ApiResponce.loding();

  setContactList(ApiResponce<contactListModel> response){
    contactlist = response;
    notifyListeners();
  }

  Future<void> ContactListApi(String token, BuildContext context) async{
    
    setContactList(ApiResponce.loding());
    _myRepo.ContactListApi(token).then((value){

      if(value.status == true){
        print(value.data);
        setContactList(ApiResponce.complated(value));
      }else{
        Utils.flushbarErrormessage(value.message.toString(), context);
      }

    }).onError((error, stackTrace){
      setContactList(ApiResponce.error(error.toString()));
    });
  }
}