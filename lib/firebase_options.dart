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
    apiKey: 'AIzaSyB0eCeLpmX2uT8S6R0d0jWmETfLMtBmS68',
    appId: '1:1010621765619:web:e13b795b9ea087a1202486',
    messagingSenderId: '1010621765619',
    projectId: 'scrum-14df0',
    authDomain: 'scrum-14df0.firebaseapp.com',
    databaseURL: 'https://scrum-14df0-default-rtdb.firebaseio.com',
    storageBucket: 'scrum-14df0.appspot.com',
    measurementId: 'G-V8Z9STWED7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJ8WE63MBnWdBVRxK3dAYsnypKVRsDaEg',
    appId: '1:1010621765619:android:9b54de7a6908a831202486',
    messagingSenderId: '1010621765619',
    projectId: 'scrum-14df0',
    databaseURL: 'https://scrum-14df0-default-rtdb.firebaseio.com',
    storageBucket: 'scrum-14df0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCniAhoVr5Iqy0qr06uSlKbCMt8uDJGrhM',
    appId: '1:1010621765619:ios:be2419948cbe06de202486',
    messagingSenderId: '1010621765619',
    projectId: 'scrum-14df0',
    databaseURL: 'https://scrum-14df0-default-rtdb.firebaseio.com',
    storageBucket: 'scrum-14df0.appspot.com',
    androidClientId: '1010621765619-flgc59ttmtd9akiu2fdkhv904suklsg2.apps.googleusercontent.com',
    iosClientId: '1010621765619-cpg9blh4i80s63hs4sd3hjjkni11cjef.apps.googleusercontent.com',
    iosBundleId: 'com.example.scrum',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCniAhoVr5Iqy0qr06uSlKbCMt8uDJGrhM',
    appId: '1:1010621765619:ios:be2419948cbe06de202486',
    messagingSenderId: '1010621765619',
    projectId: 'scrum-14df0',
    databaseURL: 'https://scrum-14df0-default-rtdb.firebaseio.com',
    storageBucket: 'scrum-14df0.appspot.com',
    androidClientId: '1010621765619-flgc59ttmtd9akiu2fdkhv904suklsg2.apps.googleusercontent.com',
    iosClientId: '1010621765619-cpg9blh4i80s63hs4sd3hjjkni11cjef.apps.googleusercontent.com',
    iosBundleId: 'com.example.scrum',
  );
}
