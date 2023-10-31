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
    apiKey: 'AIzaSyD7-TlLKWLW6M-GY8Bwp_VeWFoUJZVmNpo',
    appId: '1:795109230334:web:4f8c0aa11ae3f93af7c7af',
    messagingSenderId: '795109230334',
    projectId: 'family-board-cab4a',
    authDomain: 'family-board-cab4a.firebaseapp.com',
    storageBucket: 'family-board-cab4a.appspot.com',
    measurementId: 'G-7Z76CC26X5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhRhhGsGevCcddoPm3qhBdrpi4uKpAIkE',
    appId: '1:795109230334:android:0d71ce2fee6c6067f7c7af',
    messagingSenderId: '795109230334',
    projectId: 'family-board-cab4a',
    storageBucket: 'family-board-cab4a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvnDgZKeStMmuIjISY2eyXU4BCAr-8MPQ',
    appId: '1:795109230334:ios:cec4e120a16e3442f7c7af',
    messagingSenderId: '795109230334',
    projectId: 'family-board-cab4a',
    storageBucket: 'family-board-cab4a.appspot.com',
    androidClientId: '795109230334-7u7akv4sifk3klmja94mkrucmt3vq2sq.apps.googleusercontent.com',
    iosClientId: '795109230334-tbcssn8j1a9jbqrbg3daobdgggo65284.apps.googleusercontent.com',
    iosBundleId: 'com.example.familyboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvnDgZKeStMmuIjISY2eyXU4BCAr-8MPQ',
    appId: '1:795109230334:ios:1c88569da12ef017f7c7af',
    messagingSenderId: '795109230334',
    projectId: 'family-board-cab4a',
    storageBucket: 'family-board-cab4a.appspot.com',
    androidClientId: '795109230334-7u7akv4sifk3klmja94mkrucmt3vq2sq.apps.googleusercontent.com',
    iosClientId: '795109230334-sb5ph8celfr4cgaf2cn7fk82s0dk8gjm.apps.googleusercontent.com',
    iosBundleId: 'com.example.famibo.RunnerTests',
  );
}