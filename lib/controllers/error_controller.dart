import 'package:mobx/mobx.dart';
part 'error_controller.g.dart';

class ErrorState = _ErrorState with _$ErrorState;

abstract class _ErrorState with Store {
  @observable
  bool error;

  @observable
  String title;

  @observable
  String message;

  @computed
  bool get hasErrors => error != null && error;
}