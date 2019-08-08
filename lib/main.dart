import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:off_the_map/views/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  final FirebaseApp firebaseApp = await FirebaseApp.configure(
    name: 'off-the-map',
    options: FirebaseOptions(
      googleAppID: Platform.isIOS
          ? '1:192290382563:ios:cbd9c5bf7c55e019'
          : '1:192290382563:android:cbd9c5bf7c55e019',
      gcmSenderID: '192290382563',
      apiKey: 'AIzaSyCf_zfTguzK0ECr71vYA2dxNRY6jSlzyn4',
      projectID: 'off-the-map',
    ),
  );

  final FirebaseStorage firebaseStorage = FirebaseStorage(
    app: firebaseApp,
    storageBucket: 'gs://off-the-map.appspot.com/',
  );

  runApp(
    OffTheMap(firebaseApp: firebaseApp, firebaseStorage: firebaseStorage,),
  );
}

class OffTheMap extends StatelessWidget {
  final FirebaseApp firebaseApp;
  final FirebaseStorage firebaseStorage;

  OffTheMap({@required this.firebaseApp, @required this.firebaseStorage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseApp>.value(value: firebaseApp),
        Provider<FirebaseStorage>.value(value: firebaseStorage),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
