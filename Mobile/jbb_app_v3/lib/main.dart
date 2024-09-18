import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v3/main/app.dart';

void main(List<String> args) {
  runApp(const ProviderScope(child: App()));
}