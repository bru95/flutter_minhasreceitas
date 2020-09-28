import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:minhasreceitas/controllers/error_controller.dart';
import 'package:minhasreceitas/model/recipe.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/firebase_service.dart';
import 'package:mobx/mobx.dart';

part 'new_recipe_controller.g.dart';

class NewRecipeController = NewRecipeControllerBase with _$NewRecipeController;

abstract class NewRecipeControllerBase with Store {
  FirebaseService _api = locator<FirebaseService>();

  @observable
  Recipe _recipe = new Recipe(name: '', preparation: '', ingredients: []);

  @observable
  String auxNewIngredient = "";

  @observable
  bool success = false;

  @observable
  ErrorState errorState = ErrorState();

  @computed
  int get sizeIngredients {
    return _recipe.ingredients.length;
  }

  @computed
  List<String> get ingredients {
    return _recipe.ingredients;
  }

  @computed
  Recipe get recipe {
    return _recipe;
  }

  @action
  addIngredient() {
    List<String> ingredients = _recipe.ingredients;
    ingredients.insert(0, auxNewIngredient);
    auxNewIngredient = '';

    Recipe aux = _recipe;
    aux.ingredients = ingredients;
    _recipe = aux;
  }

  @action
  changePreparation(String preparation) {
    Recipe aux = _recipe;
    aux.preparation = preparation;
    _recipe = aux;
  }

  @action
  changeName(String name) {
    Recipe aux = _recipe;
    aux.name = name;
    _recipe = aux;
  }

  @action
  removeIngredient(int index) {
    List<String> ingredients = _recipe.ingredients;
    ingredients.removeAt(index);
    Recipe aux = _recipe;
    aux.ingredients = ingredients;
    _recipe = aux;
  }

  @action
  addRecipe() async {
    if (_recipe.name.isEmpty ||
        _recipe.preparation.isEmpty ||
        _recipe.ingredients.length == 0) {
      errorState.title = 'Por Favor';
      errorState.message = 'Preencha todos os campos';
      errorState.error = true;
    } else if (_recipe.documentId() != null) {
      _api.updateDocument(_recipe.toMap(), _recipe.documentId()).then((result) {
        success = true;
      }).catchError((error) {
        errorState.title = 'Atenção';
        errorState.message = error.toString();
        errorState.error = true;
      });
    } else {
      DocumentReference ref =
          await _api.addDocument(_recipe.toMap()).then((result) {
        success = true;
      }).catchError((error) {
        errorState.title = 'Atenção';
        errorState.message = error.toString();
        errorState.error = true;
      });
    }
  }

  @action
  deleteRecipe() async {
    if (_recipe.documentId() != null) {
      _api.removeDocument(recipe.documentId()).then((result) {
        success = true;
      }).catchError((error) {
        errorState.title = 'Atenção';
        errorState.message = error.toString();
        errorState.error = true;
      });
    } else {
      success = true;
    }
  }

  @action
  setRecipe(Recipe recipe) {
    _recipe = recipe;
  }
}
