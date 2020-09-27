import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minhasreceitas/widgets/platform_widget.dart';

class Favorites extends StatefulWidget {
  static const String title = 'Receitas Favoritas';

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  static const _itemsLength = 3;

  List<Color> colors;
  List<String> titles;
  List<String> contents;

  @override
  void initState() {
    colors = [Color(0xFFE9E9E9), Color(0xFFE9E9E9), Color(0xFFE9E9E9)];
    titles = ["Um", "Dois", "Três"];
    contents = ["Primeiro card", "Segundo card", "Terceiro card"];
    super.initState();
  }

  Widget _buildAndroidPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Favorites.title),
      ),
      body: ListView.builder(itemBuilder: _listBuilder),
    );
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return null;
    print(index);

    return SafeArea(
      top: false,
      bottom: false,
      child: Card(
        elevation: 1.5,
        margin: EdgeInsets.fromLTRB(6, 12, 6, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: InkWell(
          // Make it splash on Android. It would happen automatically if this
          // was a real card but this is just a demo. Skip the splash on iOS.
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colors[index],
                  child: Text(
                    titles[index].substring(0, 1),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                //Icon(PlatformIcons(context).heartSolid, color: Color(0xFFB22222),),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        contents[index],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIosPage(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: SafeArea(
          child: ListView.builder(
            itemBuilder: _listBuilder,
          ),
        ),
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroidPage,
      iosBuilder: _buildIosPage,
    );
  }
}
