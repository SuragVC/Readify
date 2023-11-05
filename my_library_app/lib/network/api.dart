import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_library_app/network/custom_exception.dart';
import 'package:my_library_app/schemas/schemas.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.googleapis.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
  String prefix = "v1/";
  static String apiKey = "AIzaSyBYkPWj6lMxzvETjjEbE78jBMOWb4c7ya0";

  static Future<ApiResponse> getBookListByCategory(String category) async {
    try {
      final response = await _dio.get('/books/v1/volumes', queryParameters: {
        'q': 'subject:$category',
        'key': apiKey,
        'maxResult': 30,
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            json.decode(response.toString());
        return ApiResponse.fromJson(responseData);
      } else {
        throw CustomException("Something went wrong");
      }
    } catch (error) {
      throw CustomException("Network Error: $error");
    }
  }

  static Future<Response> postBook(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post('/books', data: data);
      if (response.statusCode == 201) {
        return response;
      } else {
        return throw CustomException("Some thing went wrong");
      }
    } catch (error) {
      throw CustomException("Network Error: $error");
    }
  }
}
