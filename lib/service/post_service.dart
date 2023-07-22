import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../storage/jwt_storage.dart';


class postService {

  Future<Response> post({required String url, required Map<String, dynamic> data} ) async {
    final dio = Dio();
    dio.options.responseType = ResponseType.json;  //this code can make more secure
    final _jwt = await jwtStorageService().getJwtData();

    var response = await dio.post(
      url,
      options: Options(
        headers: {
          "Authorization": _jwt,
        },
      ),
      data: data
    );
    
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      debugPrint('Response Data: ${response.data}');
      return response;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load Proposal');
    }
    
  }
}
