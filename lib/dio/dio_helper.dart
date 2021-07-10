import 'package:dio/dio.dart';
import 'package:softag/components/consts.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'lang': 'en',
        },
        baseUrl: URL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String token = '',
  }) async {
    return await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': token,
        },
      ),
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String token = '',
  }) async {
    return await dio.post(
      url,
      data: data,
      options: Options(
        headers: {
          'Authorization': token,
        },
      ),
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
     Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String token = '',
  }) async {
    return await dio.put(
      url,
      data: data,
      options: Options(
        headers: {
          'Authorization': token,
        },
      ),
      queryParameters: query,
    );
  }

}
