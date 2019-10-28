import 'package:flutter/cupertino.dart';

class AlertPopup {
  void messageAlertPress(BuildContext context,String message) {
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Đóng'),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
        ],
      ),
    );
  }

  void showDialog({BuildContext context, Widget child}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}
