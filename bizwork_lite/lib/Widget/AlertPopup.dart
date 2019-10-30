import 'package:flutter/cupertino.dart';

class AlertPopup {
  void messageAlertPress(BuildContext context, String message) {
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

  // ignore: missing_return
  Future<bool> messageAlert2Press(BuildContext context, String message,
      String textAgree, String textCancel) {
    return showDialog<bool>(
      context: context,
      child: CupertinoAlertDialog(
        title: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(textCancel),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            child: Text(textAgree),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  Future<T> showDialog<T>({BuildContext context, Widget child}) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}
