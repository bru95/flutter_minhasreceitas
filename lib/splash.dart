import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:minhasreceitas/home.dart';
import 'package:minhasreceitas/pages/login_page.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Firebase.initializeApp().whenComplete(() {
      Future.delayed(Duration(seconds: 2)).then((_) {
        var sharedPreferences = locator<LocalStorageService>();
        if (sharedPreferences.usrLogged != null) {
          Navigator.pushReplacementNamed(context, Home.routeName);
        } else {
          Navigator.pushReplacementNamed(context, Login.routeName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Color(0xFFEDF3F5),
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/fundo.png'),
                ))
          ],
        ),
      ),
    );
  }
}
