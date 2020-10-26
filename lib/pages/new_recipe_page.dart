import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:io' show Platform;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:minhasreceitas/controllers/new_recipe_controller.dart';
import 'package:minhasreceitas/model/recipe.dart';
import 'package:mobx/mobx.dart';

class NewRecipe extends StatefulWidget {
  static const String title = 'Nova Receita';
  static const routeName = '/new_recipe';

  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  NewRecipeController controller;
  final List<ReactionDisposer> _disposers = [];

  TextEditingController nameController = new TextEditingController();
  TextEditingController preparationController = new TextEditingController();

  @override
  void initState() {
    controller = NewRecipeController();

    _disposers.add(
        reaction<bool>((_) => controller.errorState.error, _displayFlushBar));

    _disposers.add(
        reaction<Recipe>((_) => controller.recipe, _updateTextControllers));

    _disposers.add(when((_) => controller.success, () {
      _showDialogSucces();
    }));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arg = ModalRoute.of(context).settings.arguments;
    print(arg);
    super.didChangeDependencies();
  }

  void _displayFlushBar(bool error) {
    if (error) {
      controller.errorState.error = false;
      Flushbar(
        title: controller.errorState.title,
        message: controller.errorState.message,
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }

  void _updateTextControllers(Recipe data) {
    nameController.text = data.name;
    preparationController.text = data.preparation;
  }

  @override
  Widget build(context) {
    Recipe recipe = ModalRoute.of(context).settings.arguments;
    if (recipe != null) {
      controller.setRecipe(recipe);
    }

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(NewRecipe.title),
        cupertino: (context, platform) => CupertinoNavigationBarData(
            trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoButton(
              child: Icon(
                CupertinoIcons.delete_solid,
              ),
              padding: EdgeInsets.all(0.0),
              onPressed: controller.deleteRecipe,
            ),
            CupertinoButton(
              child: Icon(
                CupertinoIcons.check_mark_circled_solid,
              ),
              padding: EdgeInsets.all(0.0),
              onPressed: controller.addRecipe,
            ),
          ],
        )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "NOME",
                    style: TextStyle(
                        color: Color(0xFF8F8F8F), fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: PlatformTextField(
                      controller: nameController,
                      onChanged: controller.changeName,
                      maxLines: null,
                      material: (context, platform) => MaterialTextFieldData(
                          decoration: InputDecoration(
                              hintText: 'Como se chama sua receita?')),
                      cupertino: (context, platform) => CupertinoTextFieldData(
                          placeholder: 'Como se chama sua receita?'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "INGREDIENTES",
                    style: TextStyle(
                        color: Color(0xFF8F8F8F), fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Adicionar ingrediente",
                                  style: TextStyle(color: Color(0xFF808080)),
                                ),
                              ),
                            ],
                          ),
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            _displayDialogIngredient();
                          },
                        ),
                        Divider(),
                        Container(
                          constraints: BoxConstraints(maxHeight: 175),
                          child: Observer(
                            builder: (_) => ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: controller.sizeIngredients,
                              itemBuilder: _listItemBuilderIngredients,
                              separatorBuilder: (context, index) => Divider(
                                color: Color(0xFFE9E9E9),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 10),
                  child: Text(
                    "MODO DE PREPARO",
                    style: TextStyle(
                        color: Color(0xFF8F8F8F), fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: PlatformTextField(
                      controller: preparationController,
                      onChanged: controller.changePreparation,
                      maxLines: null,
                      material: (context, platform) => MaterialTextFieldData(
                          decoration: InputDecoration(
                              hintText: 'Como podemos preparar sua receita?')),
                      cupertino: (context, platform) => CupertinoTextFieldData(
                          placeholder: 'Como podemos preparar sua receita?'),
                    ),
                  ),
                ),
                Container(
                  //só exibe botão para outras plataformas que não IOS
                  child: !Platform.isIOS
                      ? Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: RaisedButton(
                                  child: Text("Salvar"),
                                  onPressed: controller.addRecipe,
                                  color: Colors.green,
                                  textColor: Colors.white,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(8)),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: RaisedButton(
                                  child: Text("Excluir"),
                                  onPressed: controller.deleteRecipe,
                                  color: Colors.redAccent,
                                  textColor: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )
                      : null,
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItemBuilderIngredients(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        controller.removeIngredient(index);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Observer(
              builder: (_) => Text(
                controller.ingredients[index],
                style: TextStyle(color: Color(0xFF808080)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _displayDialogIngredient() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("NOVO INGREDIENTE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: TextField(
                          onChanged: (value) =>
                              controller.auxNewIngredient = value,
                          decoration: InputDecoration(
                              hintText: 'Descrição do ingrediente'),
                        )),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                          onPressed: () {
                            controller.addIngredient();
                            Navigator.of(context, rootNavigator: true)
                                .pop("Discard");
                          },
                          child: Text(
                            "Adicionar",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.green),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () => {
                          Navigator.of(context, rootNavigator: true)
                              .pop("Discard")
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.black),
                        ),
                        color: const Color(0xFFF5F5F5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showDialogSucces() async {
    await showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text('Sucesso!'),
        content: Text('Operação realizada com sucesso!'),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ).then((value) => Navigator.pop(context));
  }
}
