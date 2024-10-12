abstract class BaseApiServices{

   Future<dynamic> getGetApiResponce(String url, {required String token});

   Future<dynamic> getpostApiResponce(String url, dynamic data);

   Future<dynamic> getPostApiResponce(String url, dynamic data, {required String token});


}