import 'package:dio/dio.dart';
abstract class NetworkCore {}

class DioInstance implements NetworkCore {
  final dio = Dio();

  DioInstance() {
    dio.options.baseUrl = ProductApiCore.baseURL;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Dio getDioInstance() {
    return dio;
  }
}

class ProductApiCore implements NetworkCore {
  static const String baseURL = 'http://192.168.1.59:8000/api';
  static const String getAllProducts = '$baseURL/products';
  static const String searchProducts = '$baseURL/products/search';
  static const String filterCategory = '$baseURL/products/category';
}