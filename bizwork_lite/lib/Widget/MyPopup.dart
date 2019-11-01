import 'package:flutter/cupertino.dart';

class MyPopup {
  Future<void> messageAlertPress(BuildContext context, String message) {
    return showDialog(
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

  void loadingPopup(BuildContext context) {
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: CupertinoActivityIndicator(),
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
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}
