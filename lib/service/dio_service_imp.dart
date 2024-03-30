import 'package:currency_converter/service/dio_service.dart';
import 'package:dio/dio.dart';

class DioServiceImp implements DioService {
  @override
  Dio getDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://api.frankfurter.app/',
        headers: {
          'content-type': 'application/json; charset=utf-8',
        },
      ),
    );
  }
}
