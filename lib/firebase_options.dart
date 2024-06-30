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
    apiKey: 'AIzaSyDpx_UwKsn1_GKXFdMg9AS0_827_NnLH38',
    appId: '1:372745410894:web:b32738e0c7fe37ba56661f',
    messagingSenderId: '372745410894',
    projectId: 'roaia-official',
    authDomain: 'roaia-official.firebaseapp.com',
    databaseURL: 'https://roaia-official-default-rtdb.firebaseio.com',
    storageBucket: 'roaia-official.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBO334ct9eVUtDSy7X4Yz9mw66imN-42oQ',
    appId: '1:372745410894:android:f6d13ded59b4a8fe56661f',
    messagingSenderId: '372745410894',
    projectId: 'roaia-official',
    databaseURL: 'https://roaia-official-default-rtdb.firebaseio.com',
    storageBucket: 'roaia-official.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3ZJfidLjodaMdp78yntBAf6oTTg55lVI',
    appId: '1:372745410894:ios:0c36e866114d961156661f',
    messagingSenderId: '372745410894',
    projectId: 'roaia-official',
    databaseURL: 'https://roaia-official-default-rtdb.firebaseio.com',
    storageBucket: 'roaia-official.appspot.com',
    iosBundleId: 'com.example.roaia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3ZJfidLjodaMdp78yntBAf6oTTg55lVI',
    appId: '1:372745410894:ios:0c36e866114d961156661f',
    messagingSenderId: '372745410894',
    projectId: 'roaia-official',
    databaseURL: 'https://roaia-official-default-rtdb.firebaseio.com',
    storageBucket: 'roaia-official.appspot.com',
    iosBundleId: 'com.example.roaia',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDpx_UwKsn1_GKXFdMg9AS0_827_NnLH38',
    appId: '1:372745410894:web:3165028765fac10256661f',
    messagingSenderId: '372745410894',
    projectId: 'roaia-official',
    authDomain: 'roaia-official.firebaseapp.com',
    databaseURL: 'https://roaia-official-default-rtdb.firebaseio.com',
    storageBucket: 'roaia-official.appspot.com',
  );
}
