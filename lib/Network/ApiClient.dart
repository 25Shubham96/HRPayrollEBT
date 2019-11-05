import 'dart:io';

import 'package:dio/dio.dart';

class ApiClient {
  Dio dio = new Dio();

  /*void getClient() async{
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    dio.options.baseUrl = "http://103.1.92.74:8098/api/";
    dio.options.headers = {
      HttpHeaders.contentTypeHeader : 'application/json',
      HttpHeaders.authorizationHeader : 'Basic A78F4134A3A841F0954EA29D5C8DBDB3'
    };
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }*/

  void getClient(String sessionId) async {
    dio.options.baseUrl = "http://202.166.211.230:8098/api/";
    dio.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Basic ${sessionId}'
    };
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  void getClientPlain() {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.baseUrl = "http://202.166.211.230:8098/api/";
    dio.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
