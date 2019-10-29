import 'package:bizwork_lite/Service/Authorization/AuthorizationService.dart';
import 'package:bizwork_lite/Service/Authorization/Dto/LoginRequestDto.dart';
import 'package:bizwork_lite/Widget/AlertPopup.dart';
import 'package:bizwork_lite/Widget/PasswordField.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginAction() async {
    try {
      var data = await AuthorizationService().login(
          LoginResquestDto(_usernameController.text, _passwordController.text));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on Exception catch (ex) {
      AlertPopup().messageAlertPress(
          context, ex.toString().replaceAll("Exception: ", ""));
    }
  }

  @override
  void initState() {
    _usernameController.text = "Biz00017";
    _passwordController.text = "1234567";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 300.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Tên đăng nhập',
              ),
            ),
            const SizedBox(height: 12.0),
            PasswordField(
              controller: _passwordController,
              fieldKey: GlobalKey<FormFieldState<String>>(),
              labelText: 'Mật khẩu',
            ),
            const SizedBox(height: 30.0),
            Center(
              child: RaisedButton(
                onPressed: () {
                  loginAction();
                },
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                child: Container(
                  width: 200.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF3EBFEA),
                        Color(0xFF047DC1),
                      ],
                    ),
                  ),
                  child: new Center(
                    child: new Text(
                      'Đăng nhập',
                      style: new TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
