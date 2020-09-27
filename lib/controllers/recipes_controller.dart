import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhasreceitas/model/recipe.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';
import 'package:mobx/mobx.dart';

part 'recipes_controller.g.dart';

class RecipesController = RecipesControllerBase with _$RecipesController;

abstract class RecipesControllerBase with Store {
  @observable
  List<Recipe> recipes = new List<Recipe>();

  @action
  void getData() {
    var sharedPreferences = locator<LocalStorageService>();
    var userId = sharedPreferences.usrLogged;

    List<Recipe> firebaseRecipes = new List<Recipe>();

    FirebaseFirestore databaseReference = FirebaseFirestore.instance;
    databaseReference
        .collection(userId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) => firebaseRecipes.add(Recipe.fromfirestoresnapshot(f)));
    });

    recipes = firebaseRecipes;
  }
}
