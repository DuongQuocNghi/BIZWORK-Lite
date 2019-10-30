import 'package:flutter/material.dart';
import 'Page/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home:new LoginPage());
//    return GestureDetector(
//      onTap: () {
//        FocusScope.of(context).requestFocus(new FocusNode());
//      },
//      child:new MaterialApp(home:new LoginPage()),
//    );
  }
}
