import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:minhasreceitas/controllers/settings_controller.dart';
import 'package:minhasreceitas/pages/login_page.dart';
import 'package:mobx/mobx.dart';

class Settings extends StatefulWidget {
  static const String title = 'Configurações';
  static const routeName = '/settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsController controller;
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    controller = SettingsController();

    _disposers.add(
        reaction<bool>((_) => controller.errorState.error, _displayFlushBar));

    _disposers.add(when((_) => !controller.isLoggedin, () {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => Login()),
      );
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
      appBar: PlatformAppBar(
        title: Text(Settings.title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  PlatformIcons(context).personSolid,
                  size: 150,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20, left: 10)),
            PlatformButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.exit_to_app,
                    color: Color(0xFFB22222),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                  ),
                  Text(
                    "Sair",
                    style: TextStyle(color: Color(0xFFB22222)),
                  ),
                ],
              ),
              onPressed: controller.logoutApp,
            )
          ],
        ),
      ),
    );
  }
}
