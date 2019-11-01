import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog {
  void loadingDialog(BuildContext context) {
    showDemoDialog(
        context: context,
        barrierDismissible: false,
        child: Center(
          child: Container(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ));
  }

  Future<T> showDemoDialog<T>(
      {BuildContext context, Widget child, bool barrierDismissible}) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => child,
    );
  }
}
