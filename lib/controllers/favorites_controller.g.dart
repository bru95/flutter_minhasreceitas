// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesController on FavoritesControllerBase, Store {
  final _$recipesAtom = Atom(name: 'FavoritesControllerBase.recipes');

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

  final _$FavoritesControllerBaseActionController =
      ActionController(name: 'FavoritesControllerBase');

  @override
  void getData() {
    final _$actionInfo =
        _$FavoritesControllerBaseActionController.startAction();
    try {
      return super.getData();
    } finally {
      _$FavoritesControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
