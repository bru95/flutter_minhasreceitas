import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minhasreceitas/pages/recipes_page.dart';
import 'package:minhasreceitas/pages/favorites_page.dart';
import 'package:minhasreceitas/pages/settings_page.dart';
import 'package:minhasreceitas/widgets/platform_widget.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  Widget _buildAndroidHomePage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          children: <Widget>[Favorites(), Recipes(), Settings()],
          index: _selectedIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text(Favorites.title),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(Recipes.title),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(Settings.title),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int tappedIndex) {
            //Toggle pageChooser and rebuild state with the index that was tapped in bottom navbar
            setState(() {
              _selectedIndex = tappedIndex;
            });
          },
        ),
      ),
    );
  }

  Widget _buildIosHomePage(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              title: Text(Favorites.title), icon: Icon(CupertinoIcons.heart)),
          BottomNavigationBarItem(
              title: Text(Recipes.title), icon: Icon(CupertinoIcons.book)),
          BottomNavigationBarItem(
              title: Text(Settings.title), icon: Icon(CupertinoIcons.settings)),
        ],
        currentIndex: 1,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              defaultTitle: Favorites.title,
              builder: (context) => Favorites(),
            );
          case 1:
            return CupertinoTabView(
              defaultTitle: Recipes.title,
              builder: (context) => Recipes(),
            );
          case 2:
            return CupertinoTabView(
              defaultTitle: Settings.title,
              builder: (context) => Settings(),
            );
          default:
            assert(false, 'Unexpected tab');
            return null;
        }
      },
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroidHomePage,
      iosBuilder: _buildIosHomePage,
    );
  }
}
