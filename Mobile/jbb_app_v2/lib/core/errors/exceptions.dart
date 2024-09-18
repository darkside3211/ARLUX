import 'package:flutter/material.dart';

class ServerException implements Exception {
  final String? message;
  ServerException({this.message});

  Widget showServerException() => Center(
          child: Column(
        children: <Widget>[
          const Icon(
            Icons.warning_amber_outlined,
            color: Colors.amber,
            
          ),
          Text(message ?? '', style: const TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic
          ),)
        ],
      ));
}

class CacheException implements Exception {
  final String? message;
  CacheException({this.message});
}
