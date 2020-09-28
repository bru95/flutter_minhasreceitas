import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhasreceitas/model/recipe.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/firebase_service.dart';
import 'package:mobx/mobx.dart';
import 'package:social_share/social_share.dart';

part 'recipes_controller.g.dart';

class RecipesController = RecipesControllerBase with _$RecipesController;

abstract class RecipesControllerBase with Store {
  FirebaseService _api = locator<FirebaseService>();

  @observable
  List<Recipe> recipes = ObservableList();

  @action
  void getData() {
    _api.streamDataCollection().listen((QuerySnapshot snapshot) {
      List<Recipe> firebaseRecipes = new List<Recipe>();
      snapshot.docs
          .forEach((f) => firebaseRecipes.add(Recipe.fromfirestoresnapshot(f)));
      recipes = firebaseRecipes;
    });
  }

  void favorite(int index) {
    recipes[index].favorite =
        recipes[index].favorite != null ? !recipes[index].favorite : true;

    _api
        .updateDocument(recipes[index].toMap(), recipes[index].documentId())
        .then((_) {
      print("success");
    });
  }

  void share(int index) {
    Recipe recipeShare = recipes[index];
    String ingredients = recipeShare.ingredients.reduce((value, element) => value + ', ' + element);

    SocialShare.shareWhatsapp(
        "Minha Receita: ${recipeShare.name} \n"
            + "Ingredientes: \n ${ingredients}"
        + "Modo de preparo: \n ${recipeShare.preparation}");

    print("Minha Receita: ${recipeShare.name} \n"
        + "Ingredientes: \n ${ingredients} \n"
        + "Modo de preparo: \n ${recipeShare.preparation}");
  }
}
