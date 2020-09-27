import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhasreceitas/controllers/error_controller.dart';
import 'package:minhasreceitas/model/recipe.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';
import 'package:mobx/mobx.dart';

part 'new_recipe_controller.g.dart';

class NewRecipeController = NewRecipeControllerBase with _$NewRecipeController;

abstract class NewRecipeControllerBase with Store {
  @observable
  Recipe _recipe = new Recipe(name: '', preparation: '', ingredients: []);

  @observable
  String auxNewIngredient = "";

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

  @action
  addIngredient() {
    List<String> ingredients = _recipe.ingredients;
    ingredients.insert(0, auxNewIngredient);
    auxNewIngredient = '';
    _recipe = Recipe(
        name: _recipe.name,
        preparation: _recipe.preparation,
        ingredients: ingredients);
  }

  @action
  changePreparation(String preparation) {
    _recipe = Recipe(
        name: _recipe.name,
        preparation: preparation,
        ingredients: _recipe.ingredients);
  }

  @action
  changeName(String name) {
    _recipe = Recipe(
        name: name,
        preparation: _recipe.preparation,
        ingredients: _recipe.ingredients);
  }

  @action
  removeIngredient(int index) {
    List<String> ingredients = _recipe.ingredients;
    ingredients.removeAt(index);
    _recipe = Recipe(
        name: _recipe.name,
        preparation: _recipe.preparation,
        ingredients: ingredients);
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
      //update
    } else {
      var sharedPreferences = locator<LocalStorageService>();
      var userId = sharedPreferences.usrLogged;

      FirebaseFirestore databaseReference = FirebaseFirestore.instance;
      DocumentReference ref =
          await databaseReference.collection(userId).add(_recipe.toMap());
      print(ref.id);
    }
  }
}
