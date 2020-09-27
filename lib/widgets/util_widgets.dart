import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minhasreceitas/widgets/platform_widget.dart';

class alertDialog extends StatelessWidget {
  String title;
  String message;

  alertDialog({this.title, this.message});

  Widget _buildAndroid(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(this.title),
      content: Text(this.message),
      actions: <Widget>[
        new FlatButton(
          child: const Text("Fechar"),
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop("Discard"),
        ),
      ],
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(this.title),
      content: Text(this.message),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: new Text("Fechar"),
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop("Discard"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}