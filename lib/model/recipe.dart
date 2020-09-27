/*import 'package:mobx/mobx.dart';
part 'recipe.g.dart';

class Recipe = _RecipeBase with _$Recipe;

abstract class _RecipeBase with Store {

  @observable
  String name = '';

  @action
  changeName(String newName) => name = newName;

  @observable
  String preparation = '';

  @action
  changePreparation(String newPreparation) => preparation = newPreparation;

  @observable
  var ingredients = ObservableList<String>();

  @action
  addIngredient(String ingredient) {
    ingredients.insert(0, ingredient);
  }

}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhasreceitas/model/base_model.dart';

class Recipe extends BaseModel{
  String _documentId;
  String name;
  String preparation;
  bool favorite = false;
  List<String> ingredients = new List<String>();

  Recipe({this.name, this.preparation, this.ingredients});

  Recipe.fromfirestoresnapshot(DocumentSnapshot document) {
    _documentId = document.id;
    Map<String, dynamic> map = document.data();

    this.name = map["name"];
    this.preparation = map["preparation"] ?? false;
    this.ingredients = List.from(map["ingredients"]);
    this.favorite = map["favorite"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = this.name;
    map['preparation'] = this.preparation;
    map['ingredients'] = this.ingredients;
    map['favorite'] = this.favorite;
    return map;
  }

  @override
  String documentId() => _documentId;

  void newIngredient(String ingredient) {
    ingredients.insert(0, ingredient);
  }

  void removeIngredient(int index) {
    ingredients.removeAt(index);
  }

  bool get getFavorite => favorite;

  set setfavorite(bool value) => favorite = value;
}

