import 'package:practical_task/data/response/status.dart';

class ApiResponce<T>{

  Status? status;
  T? data;
  String? message;

  ApiResponce(this.status, this.data, this.message);

  ApiResponce.loding() : status = Status.LODING;

  ApiResponce.complated(this.data) : status = Status.COMPLATED;

  ApiResponce.error(this.message) : status = Status.ERROR;

  @override
  String toString(){
    return "Status: $status \n Message: $message \n Data: $data";
  }

}