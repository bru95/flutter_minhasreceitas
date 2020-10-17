import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minhasreceitas/controllers/recipes_controller.dart';
import 'package:minhasreceitas/model/recipe.dart';
import 'package:minhasreceitas/pages/new_recipe_page.dart';

class Recipes extends StatefulWidget {
  static const String title = 'Minhas Receitas';
  static const routeName = '/recipes';

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  RecipesController controller = new RecipesController();

  @override
  void initState() {
    controller = RecipesController();

    controller.getData();
  }

  @override
  Widget build(context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(Recipes.title),
        cupertino: (context, platform) => CupertinoNavigationBarData(
            trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add),
          onPressed: _openNewRecipe,
        )),
      ),
      material: (context, platform) => MaterialScaffoldData(
          floatingActionButton: FloatingActionButton(
        onPressed: _openNewRecipe,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF4682B4),
      )),
      body: SafeArea(
        child: Container(
          child: Observer(
            builder: (_) => ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.recipes.length,
              itemBuilder: _listBuilder,
              separatorBuilder: (context, index) => Divider(
                color: Color(0xFFE9E9E9),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _openNewRecipe() {
    Navigator.of(context, rootNavigator: true).pushNamed(NewRecipe.routeName);
  }

  _openEditRecipe(Recipe recipe) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(NewRecipe.routeName, arguments: recipe);
  }

  Widget _listBuilder(BuildContext context, int index) {
    IconData iconFav = PlatformIcons(context).favoriteOutline;
    String textFav = "Favoritar";

    if (controller.recipes[index].favorite != null &&
        controller.recipes[index].favorite) {
      iconFav = PlatformIcons(context).favoriteSolid;
      textFav = "Desfavoritar";
    }

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
          actions: <Widget>[
            IconSlideAction(
              caption: 'Compartilhar',
              color: Colors.greenAccent,
              icon: PlatformIcons(context).share,
              onTap: () => controller.share(index),
            ),
            IconSlideAction(
              caption: textFav,
              color: Colors.red,
              icon: iconFav,
              onTap: () => controller.favorite(index),
            ),
          ],
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
                    PlatformIcons(context).book,
                    color: Colors.grey,
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Observer(
                        builder: (_) => Text(
                          controller.recipes[index].name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 8)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
