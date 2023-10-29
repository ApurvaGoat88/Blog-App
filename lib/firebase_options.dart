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
    apiKey: 'AIzaSyChLJA8WjxGFvXTSMngkxnY6yYVvsgFvQU',
    appId: '1:636925800337:web:6d0db1b34e42c30fe6b430',
    messagingSenderId: '636925800337',
    projectId: 'blogapp-3342',
    authDomain: 'blogapp-3342.firebaseapp.com',
    storageBucket: 'blogapp-3342.appspot.com',
    measurementId: 'G-NKZ2Q9PJ1Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCmf7ZQ8xL0mLz9Nq3yffx-01w2YYVFd4',
    appId: '1:636925800337:android:cf125fafa5f7e15fe6b430',
    messagingSenderId: '636925800337',
    projectId: 'blogapp-3342',
    storageBucket: 'blogapp-3342.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFIVs-v2jlavqOCTkqajzSVMiXJnWbBFM',
    appId: '1:636925800337:ios:6c93262cc6fb61c1e6b430',
    messagingSenderId: '636925800337',
    projectId: 'blogapp-3342',
    storageBucket: 'blogapp-3342.appspot.com',
    iosBundleId: 'com.example.blogApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFIVs-v2jlavqOCTkqajzSVMiXJnWbBFM',
    appId: '1:636925800337:ios:9dff19a416662f6ee6b430',
    messagingSenderId: '636925800337',
    projectId: 'blogapp-3342',
    storageBucket: 'blogapp-3342.appspot.com',
    iosBundleId: 'com.example.blogApp.RunnerTests',
  );
}