// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCyiI8uh47HWd3nx8CBe9bw2zleML_owOE',
    appId: '1:645685892432:web:2e393fefcecb37eec10855',
    messagingSenderId: '645685892432',
    projectId: 'jbb-gold',
    authDomain: 'jbb-gold.firebaseapp.com',
    storageBucket: 'jbb-gold.appspot.com',
    measurementId: 'G-LLKQ62Q5JN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4DPvJNbIpCWvydgfKTtSDRWERhXeyYrs',
    appId: '1:645685892432:android:b8392d1b02dac973c10855',
    messagingSenderId: '645685892432',
    projectId: 'jbb-gold',
    storageBucket: 'jbb-gold.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJbVQieBYxtq8YMJLdWq6pyDRqc22NpBU',
    appId: '1:645685892432:ios:41e896819456430cc10855',
    messagingSenderId: '645685892432',
    projectId: 'jbb-gold',
    storageBucket: 'jbb-gold.appspot.com',
    androidClientId: '645685892432-q8mdimdvb7umdh995m8slqlutbuu83rj.apps.googleusercontent.com',
    iosClientId: '645685892432-omq04kc2pfme9vk2u2bucp4ms5vbsl3i.apps.googleusercontent.com',
    iosBundleId: 'com.example.jbbAppV5',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJbVQieBYxtq8YMJLdWq6pyDRqc22NpBU',
    appId: '1:645685892432:ios:41e896819456430cc10855',
    messagingSenderId: '645685892432',
    projectId: 'jbb-gold',
    storageBucket: 'jbb-gold.appspot.com',
    androidClientId: '645685892432-q8mdimdvb7umdh995m8slqlutbuu83rj.apps.googleusercontent.com',
    iosClientId: '645685892432-omq04kc2pfme9vk2u2bucp4ms5vbsl3i.apps.googleusercontent.com',
    iosBundleId: 'com.example.jbbAppV5',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCyiI8uh47HWd3nx8CBe9bw2zleML_owOE',
    appId: '1:645685892432:web:5a37b4ddf4f095d7c10855',
    messagingSenderId: '645685892432',
    projectId: 'jbb-gold',
    authDomain: 'jbb-gold.firebaseapp.com',
    storageBucket: 'jbb-gold.appspot.com',
    measurementId: 'G-2PG381Y3W9',
  );

}