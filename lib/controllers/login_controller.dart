import 'package:firebase_auth/firebase_auth.dart';
import 'package:minhasreceitas/controllers/error_controller.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  @observable
  String email = '';

  @action
  changeEmail(String value) => email = value;

  @observable
  String password = '';

  @action
  changePassword(String value) => password = value;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedin = false;

  @observable
  ErrorState errorState = ErrorState();

  @action
  teste() {
    isLoading = true;
  }

  @action
  login() async {
    isLoading = true;

    if (email.isEmpty || password.isEmpty) {
      errorState.title = 'Atenção';
      errorState.message = 'Forneça e-mail e senha para fazer login';
      errorState.error = true;
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        User user = userCredential.user;
        if (user != null) {
          setUserLogged(user);
        } else {
          errorState.title = 'Desculpe';
          errorState.message = 'Ocorreu um erro, por favor tente novamente';
          errorState.error = true;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorState.title = 'Atenção';
          errorState.message = 'E-mail não encontrado';
          errorState.error = true;
        } else if (e.code == 'wrong-password') {
          errorState.title = 'Tente novamente';
          errorState.message = 'Senha inválida para e-mail informado';
          errorState.error = true;
        }
      }
    }

    isLoading = false;
  }

  @action
  register() async {
    isLoading = true;

    if (email.isEmpty || password.isEmpty) {
      errorState.title = 'Atenção';
      errorState.message = 'Forneça e-mail e senha para criar sua conta';
      errorState.error = true;
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        User user = userCredential.user;
        if (user != null) {
          setUserLogged(user);
        } else {
          errorState.title = 'Atenção';
          errorState.message = 'Ocorreu um erro, por favor tente novamente';
          errorState.error = true;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          errorState.title = 'Atenção';
          errorState.message = 'Senha muito fraca';
          errorState.error = true;
        } else if (e.code == 'email-already-in-use') {
          errorState.title = 'Atenção';
          errorState.message = 'Este e-mail já está sendo usado';
          errorState.error = true;
        }
      } catch (e) {
        print(e.toString());
      }
    }

    isLoading = false;
  }

  void setUserLogged(User user) {
    var str = '{"uid": "${user.uid}", "email": "${user.email}"}';
    var sharedPreferences = locator<LocalStorageService>();
    sharedPreferences.usrLogged = str;

    isLoggedin = true;
  }
}
