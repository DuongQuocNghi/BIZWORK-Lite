import 'package:bizwork_lite/Db/DatabaseService.dart';
import 'package:bizwork_lite/Db/Mode/UserAccount.dart';
import 'package:bizwork_lite/Service/Authorization/AuthorizationService.dart';
import 'package:bizwork_lite/Service/Authorization/Dto/LoginRequestDto.dart';
import 'package:bizwork_lite/Service/Authorization/Dto/LoginResponseDto.dart';
import 'package:bizwork_lite/Widget/AlertPopup.dart';
import 'package:bizwork_lite/Widget/EntryField.dart';
import 'package:bizwork_lite/Widget/GradientButton.dart';
import 'package:bizwork_lite/Widget/PasswordField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Home/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void GoToHome(LoginResponseDto data) async {
    try {
      await SaveAccount();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> SaveAccount() async {
    return AlertPopup().messageAlert2Press(context ,"Bạn có muốn lưu mật khẩu", "Đồng ý", "Đóng").then((bool value) async{
      if(value){
        var acc = UserAccount(userName: _usernameController.text,password: _passwordController.text);

        var service = DatabaseService();
        await service.createTable(acc);
        await service.insertData(acc);

        print("SaveAccount Done");
      }
    });
  }

  void loginAction() async {
    try {
      var data = await AuthorizationService().login(
          LoginResquestDto(_usernameController.text, _passwordController.text));

      if (data != null) {
        GoToHome(data);
      }
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
            const SizedBox(height: 150.0),
            SvgPicture.asset("assets/images/banner_logo.svg"),
            const SizedBox(height: 50.0),
            EntryField(
              controller: _usernameController,
              labelText: 'Tên đăng nhập',
            ),
            const SizedBox(height: 12.0),
            PasswordField(
              controller: _passwordController,
              labelText: 'Mật khẩu',
            ),
            const SizedBox(height: 30.0),
            Center(
                child: GradientButton(
                    onPressed: () {
                      loginAction();
                    },
                    widthSize: 200,
                    heightSize: 50,
                    labelText: "Đăng nhập",
                    cornerRadius: 25,
                    colorLabelText: Colors.white,
                    backroundColor: <Color>[
                      Color(0xFF3EBFEA),
                      Color(0xFF047DC1)
                    ])),
            const SizedBox(height: 150.0),
          ],
        ),
      ),
    );
  }

}