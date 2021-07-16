import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/route_generator.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _handleMassage();
    _iosRequestPermission();
    _handleFirebaseToken();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () async {
      Navigator.of(context).popAndPushNamed(Constant.LOGIN_PAGE);
    });

    var assetsImage = new AssetImage(
        'assets/image/test.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height: 300); //<- Creates a widget that displays an image.

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
            child: image,
          ),
        ), //<- place where the image appears
      ),
    );
  }

  _handleMassage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
  }

  _iosRequestPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  _handleFirebaseToken() {
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      var _homeScreenText;
      // setState(() {
      _homeScreenText = "Push Messaging token: $token";
      // });
      print(_homeScreenText);
    });
  }
}
