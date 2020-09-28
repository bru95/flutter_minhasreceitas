import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhasreceitas/model/recipe.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/firebase_service.dart';
import 'package:mobx/mobx.dart';

part 'favorites_controller.g.dart';

class FavoritesController = FavoritesControllerBase with _$FavoritesController;

abstract class FavoritesControllerBase with Store {
  FirebaseService _api = locator<FirebaseService>();

  @observable
  List<Recipe> recipes = ObservableList();

  @action
  void getData() {
    _api.streamDataCollectionFavorites().listen((QuerySnapshot snapshot) {
      List<Recipe> firebaseRecipes = new List<Recipe>();
      snapshot.docs
          .forEach((f) => firebaseRecipes.add(Recipe.fromfirestoresnapshot(f)));
      recipes = firebaseRecipes;
    });
  }

  void disfavor(int index) {
    recipes[index].favorite = false;
    _api.updateDocument(recipes[index].toMap(), recipes[index].documentId());
  }
}
