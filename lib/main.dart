import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:minhasreceitas/splash.dart';

import 'service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return PlatformApp(
      debugShowCheckedModeBanner: false,
      title: 'Minhas Receitas',
      material: (context, platform) => MaterialAppData (
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFF5F5F5)
        )
      ),
      cupertino: (context, platform) => CupertinoAppData (
        theme: CupertinoThemeData (
            scaffoldBackgroundColor: Color(0xFFF5F5F5)
        )
      ),
      home: Splash(),
    );
  }
}