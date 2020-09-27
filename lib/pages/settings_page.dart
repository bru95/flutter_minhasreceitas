import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minhasreceitas/widgets/platform_widget.dart';

class Settings extends StatefulWidget {
  static const String title = 'Configurações';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget _buildBody() {
    return SafeArea(
      child: Column(

      ),
    );
  }

  Widget _buildAndroidPage(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Settings.title),
        ),
        body: _buildBody());
  }

  Widget _buildIosPage(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(Settings.title)
      ),
      child: _buildBody(),
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroidPage,
      iosBuilder: _buildIosPage,
    );
  }
}
