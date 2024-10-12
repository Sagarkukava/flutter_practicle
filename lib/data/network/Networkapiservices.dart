import 'dart:convert';
import 'dart:io';

import 'package:practical_task/data/app_excaption.dart';
import 'package:practical_task/data/network/Baseapiservices.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponce(String url, {String? token}) async {

    dynamic responseJson;

    try{

      final response = await http.get(Uri.parse(url),
        headers: {
        'Authorization': 'Bearer $token',
        },
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponce(response);

    }on SocketException{
      throw FetchdataException("No Internet Connection");
    }

    return responseJson ;
  }

  @override
  Future getpostApiResponce(String url, dynamic data) async {
    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponce(response);
    } on SocketException {
      throw FetchdataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponce(String url, dynamic data, {String? token}) async {
    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponce(response);
    } on SocketException {
      throw FetchdataException("No Internet Connection");
    }
    return responseJson;
  }


  dynamic returnResponce(http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        throw BadRequesExcepation(response.body.toString());
      case 400:
        throw BadRequesExcepation(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchdataException("Error accured while communicating with server"+
            "With status code"+response.statusCode.toString());
    }
  }

}