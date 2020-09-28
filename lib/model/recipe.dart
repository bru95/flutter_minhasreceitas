import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhasreceitas/model/base_model.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';

class Recipe extends BaseModel{
  String _documentId;
  String _userId;
  String name;
  String preparation;
  bool favorite = false;
  List<String> ingredients = new List<String>();

  Recipe({this.name, this.preparation, this.ingredients}){
    var sharedPreferences = locator<LocalStorageService>();
    this._userId = sharedPreferences.usrLogged;
  }

  Recipe.fromfirestoresnapshot(DocumentSnapshot document) {
    _documentId = document.id;
    Map<String, dynamic> map = document.data();

    this.name = map["name"];
    this.preparation = map["preparation"] ?? false;
    this.ingredients = List.from(map["ingredients"]);
    this.favorite = map["favorite"];
    this._userId = map["userId"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = this.name;
    map['preparation'] = this.preparation;
    map['ingredients'] = this.ingredients;
    map['favorite'] = this.favorite;
    map['userId'] = this._userId;
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

  set setFavorite(bool value) => favorite = value;
}

