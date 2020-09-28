import 'package:firebase_auth/firebase_auth.dart';
import 'package:minhasreceitas/controllers/error_controller.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';
import 'package:mobx/mobx.dart';

part 'settings_controller.g.dart';

class SettingsController = SettingsControllerBase with _$SettingsController;

abstract class SettingsControllerBase with Store {
  @observable
  bool isLoggedin = true;

  @observable
  ErrorState errorState = ErrorState();

  @action
  logoutApp() async {
    try {
      await FirebaseAuth.instance.signOut();
      var sharedPreferences = locator<LocalStorageService>();
      sharedPreferences.removeLoginDate();
      sharedPreferences.removeUsrLogged();

      isLoggedin = false;
    } on FirebaseAuthException catch (e) {
      errorState.title = 'Atenção';
      errorState.message = e.message;
      errorState.error = true;
    }
  }
}
