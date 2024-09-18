import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkConfig {
  Future<bool>? get isConnected;
}

class NetworkConfigImpl implements NetworkConfig {
  @override
  Future<bool>? get isConnected async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}

class DioInstance {
  final dio = Dio();

  DioInstance() {
    dio.options.baseUrl = 'http://192.168.1.59:8000/api';
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Dio getDioInstance() {
    return dio;
  }
}
