import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:minhasreceitas/home.dart';
import 'package:minhasreceitas/pages/favorites_page.dart';
import 'package:minhasreceitas/pages/login_page.dart';
import 'package:minhasreceitas/pages/new_recipe_page.dart';
import 'package:minhasreceitas/pages/recipes_page.dart';
import 'package:minhasreceitas/pages/settings_page.dart';
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
      routes: {
        Home.routeName: (context) => Home(),
        Login.routeName: (context) => Login(),
        NewRecipe.routeName: (context) => NewRecipe(),
        Favorites.routeName: (context) => Favorites(),
        Recipes.routeName: (context) => Recipes(),
        Settings.routeName: (context) => Settings()
      },
      debugShowCheckedModeBanner: false,
      title: 'Minhas Receitas',
      material: (context, platform) => MaterialAppData(
          theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFFF5F5F5),
              primaryColor: Color(0xFF4682B4))),
      cupertino: (context, platform) => CupertinoAppData(
          theme:
              CupertinoThemeData(scaffoldBackgroundColor: Color(0xFFF5F5F5))),
      home: Splash(),
    );
  }
}
