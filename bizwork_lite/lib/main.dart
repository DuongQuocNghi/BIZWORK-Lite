import 'package:flutter/material.dart';
import 'Page/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child:new MaterialApp(home:new LoginPage()),
    );
  }
}
