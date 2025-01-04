import 'package:crypto_app/consts.dart';
import 'package:dio/dio.dart';

class HttpServices {
  final Dio _dio = Dio();

  HttpServices() {
    configureDio();
  }

  void configureDio() {
    _dio.options = BaseOptions(
      baseUrl: 'https://api.cryptorank.io/v1/',
      queryParameters: {
        'api_key': Crypto_rank_ApiKey,
      },
    );
  }

  Future<dynamic> get(String path) async {
    try {
      Response response = await _dio.get(path);
      return response.data;
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}
