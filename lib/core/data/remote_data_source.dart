import 'dart:convert';

import 'package:dio/dio.dart';

class RemoteDataSource {
  Dio dio = Dio();
  Future<dynamic> getData(String url) async {
    try {
      Response response = await dio.get(url);
      return response.data;
    } catch (err) {
      rethrow;
    }
  }

  Future<dynamic> postData(String url, dynamic data) async {
    Response response = await dio.post(url, data: data);
    var jsonResponse = jsonDecode(response.data);
    return jsonResponse;
  }
}