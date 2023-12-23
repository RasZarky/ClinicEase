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
        return macos;
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
    apiKey: 'AIzaSyABvxEH5UjayUiLBvYE9XDwuvbcMdI1wzc',
    appId: '1:15672070886:web:577ca5b1eca4db4f55a127',
    messagingSenderId: '15672070886',
    projectId: 'clinicease-af5a4',
    authDomain: 'clinicease-af5a4.firebaseapp.com',
    databaseURL: 'https://clinicease-af5a4-default-rtdb.firebaseio.com',
    storageBucket: 'clinicease-af5a4.appspot.com',
    measurementId: 'G-9M4T2BCWWP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_FJQBTrxZrGFIthmfgq3uPIRsTgLZM6M',
    appId: '1:15672070886:android:51ac39cd277d6d8955a127',
    messagingSenderId: '15672070886',
    projectId: 'clinicease-af5a4',
    databaseURL: 'https://clinicease-af5a4-default-rtdb.firebaseio.com',
    storageBucket: 'clinicease-af5a4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeAGa_JWJRpZBV70ChNJIoyEJzbCdtIhU',
    appId: '1:15672070886:ios:0febae1b38eae8aa55a127',
    messagingSenderId: '15672070886',
    projectId: 'clinicease-af5a4',
    databaseURL: 'https://clinicease-af5a4-default-rtdb.firebaseio.com',
    storageBucket: 'clinicease-af5a4.appspot.com',
    androidClientId: '15672070886-vujf2apicakfh68m0pjs91q18k5k0u63.apps.googleusercontent.com',
    iosClientId: '15672070886-9f1dv2eeblho8qb54aqsfrmpsjudskf4.apps.googleusercontent.com',
    iosBundleId: 'com.example.myccaa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCeAGa_JWJRpZBV70ChNJIoyEJzbCdtIhU',
    appId: '1:15672070886:ios:929f561fd1cae32555a127',
    messagingSenderId: '15672070886',
    projectId: 'clinicease-af5a4',
    databaseURL: 'https://clinicease-af5a4-default-rtdb.firebaseio.com',
    storageBucket: 'clinicease-af5a4.appspot.com',
    androidClientId: '15672070886-vujf2apicakfh68m0pjs91q18k5k0u63.apps.googleusercontent.com',
    iosClientId: '15672070886-45ccoterpt1lu0bn8gj3fmjb2k8cfgnq.apps.googleusercontent.com',
    iosBundleId: 'com.example.myccaa.RunnerTests',
  );
}
