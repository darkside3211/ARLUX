import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class NetworkCore {}

class DioInstance implements NetworkCore {
  final Dio _dio = Dio();

  final String localHost = 'http://192.168.1.59:8000';
  final String publicHost = 'https://jbb-back-end.onrender.com';

  DioInstance() {
    _dio.options.baseUrl = '$publicHost/api';
    _dio.options.connectTimeout = const Duration(seconds: 8);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
  }

  Dio getDioInstance() {
    return _dio;
  }
}

class LaunchMessenger implements NetworkCore {
  final String facebookID = 'https://m.me/jbbgold';

  LaunchMessenger() {
    launchMessenger();
  }

  void launchMessenger() async {
    if (await canLaunchUrl(Uri.parse(facebookID))) {
      await launchUrl(Uri.parse(facebookID));
    } else {
      throw 'Could not launch $facebookID';
    }
  }
}

class LaunchCheckout implements NetworkCore {
  final String checkoutUrl;

  LaunchCheckout({required this.checkoutUrl}) {
    launchCheckout();
  }

  void launchCheckout() async {
    if (await canLaunchUrl(Uri.parse(checkoutUrl))) {
      await launchUrl(Uri.parse(checkoutUrl));
    } else {
      throw 'Could not launch $checkoutUrl';
    }
  }
}

class LaunchLBCTracking implements NetworkCore {
  final String trackUrl = 'https://www.lbcexpress.com/track/';

  LaunchLBCTracking() {
    launchLBCTracking();
  }

  void launchLBCTracking() async {
    if (await canLaunchUrl(Uri.parse(trackUrl))) {
      await launchUrl(Uri.parse(trackUrl));
    } else {
      throw 'Could not launch $trackUrl';
    }
  }
}
