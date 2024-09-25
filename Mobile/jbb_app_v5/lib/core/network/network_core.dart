import 'package:dio/dio.dart';

abstract class NetworkCore {}

class DioInstance implements NetworkCore {
  final Dio _dio = Dio();

  DioInstance() {
    _dio.options.baseUrl = 'http://${HostAddress.value}/api';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Dio getDioInstance() {
    return _dio;
  }
}

class HostAddress {
  static String _ip = '192.168.1.59';
  static String _port = '8000';

  static void setValue({required String newIp, required String newPort}) {
    _ip = newIp;
    _port = newPort;
  }

  static String get value => '$_ip:$_port';
}
