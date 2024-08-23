import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gshop/presentation/app_widget.dart';
import 'domain/di/dependency_manager.dart';
import 'infrastructure/local_storage/local_storage.dart';
import './firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DownloadClass {
  static void callback(String id, int status, int progress) {}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("0000xxx");
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  print("0000");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print("11111");

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  print("2222");

 if(!kIsWeb){
   print("3333");

   await FlutterDownloader.initialize(debug: true);
   print("4444");

   FlutterDownloader.registerCallback(DownloadClass.callback);
   print("5555");

 }

  // await FlutterDownloader.initialize();
  // FlutterDownloader.registerCallback(DownloadClass.callback);
  print("6666");

  await LocalStorage.init();
  print("7777");

  setUpDependencies();
  print("8888");

  runApp(const AppWidget());
  print("999");

}
/*void main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const AppWidget());
}*/

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
