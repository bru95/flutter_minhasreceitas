// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on SettingsControllerBase, Store {
  final _$isLoggedinAtom = Atom(name: 'SettingsControllerBase.isLoggedin');

  @override
  bool get isLoggedin {
    _$isLoggedinAtom.context.enforceReadPolicy(_$isLoggedinAtom);
    _$isLoggedinAtom.reportObserved();
    return super.isLoggedin;
  }

  @override
  set isLoggedin(bool value) {
    _$isLoggedinAtom.context.conditionallyRunInAction(() {
      super.isLoggedin = value;
      _$isLoggedinAtom.reportChanged();
    }, _$isLoggedinAtom, name: '${_$isLoggedinAtom.name}_set');
  }

  final _$errorStateAtom = Atom(name: 'SettingsControllerBase.errorState');

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

  final _$logoutAppAsyncAction = AsyncAction('logoutApp');

  @override
  Future logoutApp() {
    return _$logoutAppAsyncAction.run(() => super.logoutApp());
  }
}
