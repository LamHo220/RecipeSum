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
    apiKey: 'AIzaSyCyCt-sumXceew6RUZhY2JFwzOrK0joV3A',
    appId: '1:317620086799:web:ea80e339c064535efc9b7a',
    messagingSenderId: '317620086799',
    projectId: 'recipe-sum',
    authDomain: 'recipe-sum.firebaseapp.com',
    storageBucket: 'recipe-sum.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuaZMsZWpKX6j087EufCwR6urKMAxj130',
    appId: '1:317620086799:android:d718683d460abcc8fc9b7a',
    messagingSenderId: '317620086799',
    projectId: 'recipe-sum',
    storageBucket: 'recipe-sum.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJ2n8Dp8hKU3mtNwZpzESHMDKk24b-la4',
    appId: '1:317620086799:ios:e68c85f62cfc3404fc9b7a',
    messagingSenderId: '317620086799',
    projectId: 'recipe-sum',
    storageBucket: 'recipe-sum.appspot.com',
    iosClientId: '317620086799-9ac00597cbsp3tj8vhqmbd8e0g8u13os.apps.googleusercontent.com',
    iosBundleId: 'com.example.recipeBox',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJ2n8Dp8hKU3mtNwZpzESHMDKk24b-la4',
    appId: '1:317620086799:ios:e68c85f62cfc3404fc9b7a',
    messagingSenderId: '317620086799',
    projectId: 'recipe-sum',
    storageBucket: 'recipe-sum.appspot.com',
    iosClientId: '317620086799-9ac00597cbsp3tj8vhqmbd8e0g8u13os.apps.googleusercontent.com',
    iosBundleId: 'com.example.recipeBox',
  );
}