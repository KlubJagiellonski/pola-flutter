// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBq9fC6W36LootBkLfe8cwFP86IlbMqq3I',
    appId: '1:141685978964:web:dcd7404317e1bad083bac1',
    messagingSenderId: '141685978964',
    projectId: 'pola-8682d',
    authDomain: 'pola-8682d.firebaseapp.com',
    databaseURL: 'https://pola-8682d.firebaseio.com',
    storageBucket: 'pola-8682d.appspot.com',
    measurementId: 'G-WSCC661941',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDq5PHrG1K23zdQheQNrNJyHO9U5erB-es',
    appId: '1:141685978964:android:b8209bcc91533ca0',
    messagingSenderId: '141685978964',
    projectId: 'pola-8682d',
    databaseURL: 'https://pola-8682d.firebaseio.com',
    storageBucket: 'pola-8682d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrR0dop-_sAzlQfdPCmHV4X_DFuE5hx6I',
    appId: '1:141685978964:ios:829127cbbf25621c83bac1',
    messagingSenderId: '141685978964',
    projectId: 'pola-8682d',
    databaseURL: 'https://pola-8682d.firebaseio.com',
    storageBucket: 'pola-8682d.appspot.com',
    androidClientId: '141685978964-c8sgmo40meiqkfeu9654lkjh93kgh19j.apps.googleusercontent.com',
    iosClientId: '141685978964-gi5o9diukaenjb9ema7hgp20gpev1jdm.apps.googleusercontent.com',
    iosBundleId: 'pl.pola.flutter',
  );
}
