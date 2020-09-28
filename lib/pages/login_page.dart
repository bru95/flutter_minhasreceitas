import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:minhasreceitas/controllers/login_controller.dart';
import 'package:minhasreceitas/home.dart';
import 'package:mobx/mobx.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController controller;
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    controller = LoginController();

    _disposers.add(
        reaction<bool>((_) => controller.errorState.error, _displayFlushBar));

    _disposers.add(when((_) => controller.isLoggedin, () {
      Navigator.pushReplacementNamed(context, Home.routeName);
    }));

    super.initState();
  }

  void _displayFlushBar(bool error) {
    if (error) {
      controller.errorState.error = false;
      Flushbar(
        title: controller.errorState.title,
        message: controller.errorState.message,
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  void dispose() {
    _disposers.forEach((disposer) => disposer());
    super.dispose();
  }

  @override
  Widget build(context) {
    return PlatformScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset('assets/images/fundo.png'),
                ),
              ),
              Text(
                'Faça seu Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
                child: PlatformTextField(
                  onChanged: controller.changeEmail,
                  maxLines: 1,
                  material: (context, platform) => MaterialTextFieldData(
                    decoration: InputDecoration(
                        hintText: 'E-mail',
                        prefixIcon: Icon(Icons.mail, color: Colors.grey)),
                  ),
                  cupertino: (context, platform) => CupertinoTextFieldData(
                      placeholder: 'E-mail',
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child:
                            Icon(CupertinoIcons.mail_solid, color: Colors.grey),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: PlatformTextField(
                  obscureText: true,
                  onChanged: controller.changePassword,
                  maxLines: 1,
                  material: (context, platform) => MaterialTextFieldData(
                    decoration: InputDecoration(
                        hintText: 'Senha',
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.grey)),
                  ),
                  cupertino: (context, platform) => CupertinoTextFieldData(
                      placeholder: 'Senha',
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.vpn_key, color: Colors.grey),
                      )),
                ),
              ),
              Container(
                child: Observer(
                  builder: (_) {
                    return controller.isLoading
                        ? PlatformCircularProgressIndicator()
                        : PlatformButton(
                            child: Text('ENTRAR'),
                            color: Colors.green,
                            onPressed: controller.login,
                            material: (context, platform) =>
                                MaterialRaisedButtonData(
                              textColor: Colors.white,
                            ),
                            cupertino: (context, platform) =>
                                CupertinoButtonData(color: Colors.green),
                          );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Observer(
                  builder: (_) {
                    return controller.isLoading
                        ? Text('Carregando ...')
                        : PlatformButton(
                            child: Text('CRIAR CONTA'),
                            color: Colors.grey,
                            onPressed: controller.register,
                            material: (context, platform) =>
                                MaterialRaisedButtonData(
                              textColor: Colors.white,
                            ),
                            cupertino: (context, platform) =>
                                CupertinoButtonData(color: Colors.grey),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
