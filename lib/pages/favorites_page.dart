import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minhasreceitas/controllers/favorites_controller.dart';
import 'package:minhasreceitas/model/recipe.dart';
import 'package:minhasreceitas/pages/new_recipe_page.dart';

class Favorites extends StatefulWidget {
  static const String title = 'Receitas Favoritas';
  static const routeName = '/favorites';

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  FavoritesController controller;

  @override
  void initState() {
    controller = FavoritesController();
    controller.getData();
    super.initState();
  }

  _openEditRecipe(Recipe recipe) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(NewRecipe.routeName, arguments: recipe);
  }

  Widget _listBuilder(BuildContext context, int index) {
    return SafeArea(
        top: false,
        bottom: false,
        child: GestureDetector(
          onTap: () {
            _openEditRecipe(controller.recipes[index]);
          },
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Card(
              elevation: 1.5,
              margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      PlatformIcons(context).heartSolid,
                      color: Color(0xFFB22222),
                    ),
                    Padding(padding: EdgeInsets.only(left: 16)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.recipes[index].name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 8)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                  caption: 'Desfavoritar',
                  color: Colors.red,
                  icon: PlatformIcons(context).favoriteSolid,
                  onTap: () => controller.disfavor(index))
            ],
          ),
        ));
  }

  @override
  Widget build(context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
          title: Text(
        Favorites.title,
      )),
      body: SafeArea(
        child: Observer(
          builder: (_) => controller.recipes.length > 0
              ? ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: controller.recipes.length,
                  itemBuilder: _listBuilder,
                  separatorBuilder: (context, index) => Divider(
                    color: Color(0xFFE9E9E9),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.mood_bad,
                        size: 150,
                      ),
                    ),
                    Center(
                        child:
                            Text("Você ainda não possui receitas favoritas!"))
                  ],
                ),
        ),
      ),
    );
  }
}
