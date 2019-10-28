import 'package:flutter/material.dart';
import 'Service/Authorization/AuthorizationService.dart';
import 'Service/Authorization/Dto/LoginRequestDto.dart';
import 'Widget/PasswordField.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(home: LoginPage()),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class UserLoginData {
  String userName;
  String password;
}

class _LoginPageState extends State<LoginPage> {
  UserLoginData userLogin = UserLoginData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 300.0),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: false,
                labelText: 'Tên đăng nhập',
              ),
              onFieldSubmitted: (String value) {
                setState(() {
                  print("Tên đăng nhập" + value);
                  userLogin.userName = value;
                });
              },
            ),
            const SizedBox(height: 12.0),
            PasswordField(
              fieldKey: GlobalKey<FormFieldState<String>>(),
              labelText: 'Mật khẩu',
              onFieldSubmitted: (String value) {
                setState(() {
                  userLogin.password = value;
                });
              },
            ),
            const SizedBox(height: 30.0),
            Center(
              child: RaisedButton(
                onPressed: () async {
                  try {
                    var data = await AuthorizationService().login(
                        LoginResquestDto(
                            "Biz00017", "1234567"));
//                    userLogin.userName, userLogin.password));

                    print(data.fullName);
                  } on Exception catch (ex) {
                    print(ex);
                  }
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
