import 'package:Alarm/Models/loops.dart';
import 'package:Alarm/Models/music.dart';
import 'package:Alarm/Providers/nowplaying_provider.dart';
import 'package:Alarm/Screen/Loading/loading.dart';
import 'package:Alarm/Services/firestore_service.dart';
import 'package:Alarm/Services/firestore_service_loops.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Screen/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirestoreService _db = FirestoreService();
  final FirestoreServiceLoops _dpLoops = FirestoreServiceLoops();
  FirebaseAdMob.instance
      .initialize(appId: 'ca-app-pub-8300119033769700~3662874260');

  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        StreamProvider<List<Music>>(create: (_) => _db.getMusic()),
        ChangeNotifierProvider(create: (_) => NowPlayingProvider()),
        StreamProvider<List<Loops>>(create: (_) => _dpLoops.getLoops()),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ConnectivityAppWrapper(
      app: MaterialApp(
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: Loading(),
        ),
        title: 'Night Time',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Mon',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          // '/': (context) => Loading(),
          '/second': (context) => SecondMusic(),
          '/allMusic': (context) => AllMusic()
        },
      ),
    );
  }
}
