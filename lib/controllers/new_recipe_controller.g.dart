// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_recipe_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewRecipeController on NewRecipeControllerBase, Store {
  Computed<int> _$sizeIngredientsComputed;

  @override
  int get sizeIngredients =>
      (_$sizeIngredientsComputed ??= Computed<int>(() => super.sizeIngredients))
          .value;
  Computed<List<String>> _$ingredientsComputed;

  @override
  List<String> get ingredients => (_$ingredientsComputed ??=
          Computed<List<String>>(() => super.ingredients))
      .value;
  Computed<Recipe> _$recipeComputed;

  @override
  Recipe get recipe =>
      (_$recipeComputed ??= Computed<Recipe>(() => super.recipe)).value;

  final _$_recipeAtom = Atom(name: 'NewRecipeControllerBase._recipe');

  @override
  Recipe get _recipe {
    _$_recipeAtom.context.enforceReadPolicy(_$_recipeAtom);
    _$_recipeAtom.reportObserved();
    return super._recipe;
  }

  @override
  set _recipe(Recipe value) {
    _$_recipeAtom.context.conditionallyRunInAction(() {
      super._recipe = value;
      _$_recipeAtom.reportChanged();
    }, _$_recipeAtom, name: '${_$_recipeAtom.name}_set');
  }

  final _$auxNewIngredientAtom =
      Atom(name: 'NewRecipeControllerBase.auxNewIngredient');

  @override
  String get auxNewIngredient {
    _$auxNewIngredientAtom.context.enforceReadPolicy(_$auxNewIngredientAtom);
    _$auxNewIngredientAtom.reportObserved();
    return super.auxNewIngredient;
  }

  @override
  set auxNewIngredient(String value) {
    _$auxNewIngredientAtom.context.conditionallyRunInAction(() {
      super.auxNewIngredient = value;
      _$auxNewIngredientAtom.reportChanged();
    }, _$auxNewIngredientAtom, name: '${_$auxNewIngredientAtom.name}_set');
  }

  final _$successAtom = Atom(name: 'NewRecipeControllerBase.success');

  @override
  bool get success {
    _$successAtom.context.enforceReadPolicy(_$successAtom);
    _$successAtom.reportObserved();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.context.conditionallyRunInAction(() {
      super.success = value;
      _$successAtom.reportChanged();
    }, _$successAtom, name: '${_$successAtom.name}_set');
  }

  final _$errorStateAtom = Atom(name: 'NewRecipeControllerBase.errorState');

  @override
  ErrorState get errorState {
    _$errorStateAtom.context.enforceReadPolicy(_$errorStateAtom);
    _$errorStateAtom.reportObserved();
    return super.errorState;
  }

  @override
  set errorState(ErrorState value) {
    _$errorStateAtom.context.conditionallyRunInAction(() {
      super.errorState = value;
      _$errorStateAtom.reportChanged();
    }, _$errorStateAtom, name: '${_$errorStateAtom.name}_set');
  }

  final _$addRecipeAsyncAction = AsyncAction('addRecipe');

  @override
  Future addRecipe() {
    return _$addRecipeAsyncAction.run(() => super.addRecipe());
  }

  final _$deleteRecipeAsyncAction = AsyncAction('deleteRecipe');

  @override
  Future deleteRecipe() {
    return _$deleteRecipeAsyncAction.run(() => super.deleteRecipe());
  }

  final _$NewRecipeControllerBaseActionController =
      ActionController(name: 'NewRecipeControllerBase');

  @override
  dynamic addIngredient() {
    final _$actionInfo =
        _$NewRecipeControllerBaseActionController.startAction();
    try {
      return super.addIngredient();
    } finally {
      _$NewRecipeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePreparation(String preparation) {
    final _$actionInfo =
        _$NewRecipeControllerBaseActionController.startAction();
    try {
      return super.changePreparation(preparation);
    } finally {
      _$NewRecipeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeName(String name) {
    final _$actionInfo =
        _$NewRecipeControllerBaseActionController.startAction();
    try {
      return super.changeName(name);
    } finally {
      _$NewRecipeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeIngredient(int index) {
    final _$actionInfo =
        _$NewRecipeControllerBaseActionController.startAction();
    try {
      return super.removeIngredient(index);
    } finally {
      _$NewRecipeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRecipe(Recipe recipe) {
    final _$actionInfo =
        _$NewRecipeControllerBaseActionController.startAction();
    try {
      return super.setRecipe(recipe);
    } finally {
      _$NewRecipeControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
