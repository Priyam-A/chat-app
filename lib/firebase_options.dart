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
    apiKey: 'AIzaSyAeXKRcnZnkMinu2of5q27n-Gv9k9avGjo',
    appId: '1:870332696408:web:a6a9d19b533bac4c13872d',
    messagingSenderId: '870332696408',
    projectId: 'chatta-5cf3e',
    authDomain: 'chatta-5cf3e.firebaseapp.com',
    storageBucket: 'chatta-5cf3e.appspot.com',
    measurementId: 'G-626CDWE979',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBertvwjUwLCjBS4tc8fLZ0nCcOXq84EAc',
    appId: '1:870332696408:android:8d382dcb9af386bc13872d',
    messagingSenderId: '870332696408',
    projectId: 'chatta-5cf3e',
    storageBucket: 'chatta-5cf3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmIUsk7n1o7pSTqfJ9gsRt8bU3EJ8jgik',
    appId: '1:870332696408:ios:d334708d20295e4013872d',
    messagingSenderId: '870332696408',
    projectId: 'chatta-5cf3e',
    storageBucket: 'chatta-5cf3e.appspot.com',
    iosBundleId: 'com.example.flutterApplication3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmIUsk7n1o7pSTqfJ9gsRt8bU3EJ8jgik',
    appId: '1:870332696408:ios:d334708d20295e4013872d',
    messagingSenderId: '870332696408',
    projectId: 'chatta-5cf3e',
    storageBucket: 'chatta-5cf3e.appspot.com',
    iosBundleId: 'com.example.flutterApplication3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAeXKRcnZnkMinu2of5q27n-Gv9k9avGjo',
    appId: '1:870332696408:web:e7ec234efde70abb13872d',
    messagingSenderId: '870332696408',
    projectId: 'chatta-5cf3e',
    authDomain: 'chatta-5cf3e.firebaseapp.com',
    storageBucket: 'chatta-5cf3e.appspot.com',
    measurementId: 'G-8GQ6GLSJPF',
  );

}