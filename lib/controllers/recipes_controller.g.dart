// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecipesController on RecipesControllerBase, Store {
  final _$recipesAtom = Atom(name: 'RecipesControllerBase.recipes');

  @override
  List<Recipe> get recipes {
    _$recipesAtom.context.enforceReadPolicy(_$recipesAtom);
    _$recipesAtom.reportObserved();
    return super.recipes;
  }

  @override
  set recipes(List<Recipe> value) {
    _$recipesAtom.context.conditionallyRunInAction(() {
      super.recipes = value;
      _$recipesAtom.reportChanged();
    }, _$recipesAtom, name: '${_$recipesAtom.name}_set');
  }

  final _$RecipesControllerBaseActionController =
      ActionController(name: 'RecipesControllerBase');

  @override
  void getData() {
    final _$actionInfo = _$RecipesControllerBaseActionController.startAction();
    try {
      return super.getData();
    } finally {
      _$RecipesControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
