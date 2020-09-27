import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:io' show Platform;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:minhasreceitas/controllers/new_recipe_controller.dart';
import 'package:minhasreceitas/widgets/util_widgets.dart';
import 'package:mobx/mobx.dart';

class NewRecipe extends StatefulWidget {
  static const String title = 'Nova Receita';

  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  NewRecipeController controller;
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    controller = NewRecipeController();

    _disposers.add(
        reaction<bool>((_) => controller.errorState.error, _displayFlushBar));

    super.initState();
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

  @override
  Widget build(context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(NewRecipe.title),
        cupertino: (context, platform) => CupertinoNavigationBarData(
            trailing: CupertinoButton(
          child: Text("Salvar"),
          padding: EdgeInsets.all(0.0),
          onPressed: controller.addRecipe,
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
                          child: SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              child: Text("Salvar"),
                              onPressed: controller.addRecipe,
                              color: Colors.green,
                              textColor: Colors.white,
                            ),
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
    return showPlatformModalSheet(
      androidIsScrollControlled: true,
      context: context,
      builder: (_) => PlatformWidget(
        material: _DialogWithTextField,
        cupertino: _DialogWithTextField,
      ),
    );
  }

  Widget _DialogWithTextField(context, platform) => SingleChildScrollView(
    child: Container (
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "NOVO INGREDIENTE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                  padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
                  child: PlatformTextField(
                    onChanged: (value) => controller.auxNewIngredient = value,
                    maxLines: 1,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PlatformButton(
                    child: Text("Cancelar"),
                    onPressed: () => {
                      Navigator.of(context, rootNavigator: true).pop("Discard")
                    },
                  ),
                  PlatformButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      controller.addIngredient();
                      Navigator.of(context, rootNavigator: true).pop("Discard");
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
