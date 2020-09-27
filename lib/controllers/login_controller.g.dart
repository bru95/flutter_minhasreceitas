// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on LoginControllerBase, Store {
  final _$emailAtom = Atom(name: 'LoginControllerBase.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: 'LoginControllerBase.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: 'LoginControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$isLoggedinAtom = Atom(name: 'LoginControllerBase.isLoggedin');

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

  final _$errorStateAtom = Atom(name: 'LoginControllerBase.errorState');

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

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$registerAsyncAction = AsyncAction('register');

  @override
  Future register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  final _$LoginControllerBaseActionController =
      ActionController(name: 'LoginControllerBase');

  @override
  dynamic changeEmail(String value) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction();
    try {
      return super.changeEmail(value);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(String value) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction();
    try {
      return super.changePassword(value);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic teste() {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction();
    try {
      return super.teste();
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
