import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:gamershub/wallet/add_amount.dart';
// import 'package:gamershub/home/home_body.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamershub/authentication/login.dart';
import 'package:gamershub/splashScreen/splash.dart';
// import 'package:gamershub/wallet/wallet.dart';
import 'package:in_app_update/in_app_update.dart';
// import 'package:gamershub/authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff9E9CF5),
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirebaseMessaging _fcm = FirebaseMessaging();
  AppUpdateInfo _updateInfo;
  bool updateData;
  bool isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  void _showError(dynamic exception) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.black38,
      content: Text(
        exception.toString(),
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontFamily: "Quicksand",
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: Duration(seconds: 3),
    ));
  }

  // Future<void> checkForUpdate() async {

  //   await InAppUpdate.checkForUpdate().then((info) => {
  //     _updateInfo = info,
  //     print(_updateInfo?.updateAvailable),
  //     updateData = _updateInfo?.updateAvailable
  //   }).catchError((e) => _showError(e));
  //   // print('_updateInfo?.immediateUpdateAllowed -> ${_updateInfo?.immediateUpdateAllowed}');
  //   // print('_updateInfo?.immediateUpdateAllowed -> $_updateInfo?.immediateUpdateAllowed');
  //   // print('_updateInfo?.flexibleUpdateAllowed -> ${_updateInfo?.flexibleUpdateAllowed}');
  //   if(_updateInfo?.updateAvailable == true || _updateInfo?.immediateUpdateAllowed == true) {
  //     // print("----");
  //     InAppUpdate.performImmediateUpdate().catchError((e) => _showError(e));
  //     // print("====");
  //   }
  //   // if()
  // }

  @override
  void initState() {
    super.initState();
    // _fcm.getToken().then((value) => {
    //       // print(value)
    //     });

    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
    // checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : LoginPage(),
      // routes: {
      // '/login': (ctx) => LoginPage(),
      // '/home': (ctx) => HomeBody(),
      // '/addamount': (ctx) => AddAmountPage(),
      // '/wallet': (ctx) => WalletPage(),
      // },
    );
  }
}
