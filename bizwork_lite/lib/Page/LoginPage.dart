import 'package:bizwork_lite/Db/DatabaseService.dart';
import 'package:bizwork_lite/Db/Mode/UserAccount.dart';
import 'package:bizwork_lite/Service/Authorization/AuthorizationService.dart';
import 'package:bizwork_lite/Service/Authorization/Dto/LoginRequestDto.dart';
import 'package:bizwork_lite/Service/Authorization/Dto/LoginResponseDto.dart';
import 'package:bizwork_lite/Widget/AlertPopup.dart';
import 'package:bizwork_lite/Widget/AutoCompleteTextField.dart';
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
  List<UserAccount> userAccounts = List();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => pageLoadFinish(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 100.0),
            SvgPicture.asset("assets/images/banner_logo.svg", height: 150),
            const SizedBox(height: 50.0),
            AutoCompleteTextField(
                controller: _usernameController,
                labelText: 'Tên đăng nhập',
                suggestionsCallback: (pattern) {
                  return getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  var data = suggestion as UserAccount;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Expanded(child: Text(data.userName.toUpperCase())),
                            GestureDetector(
                              onTap: () {
                                removeAccount(data);
                              },
                              child: Icon(Icons.delete),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.black12,
                      )
                    ],
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  var data = suggestion as UserAccount;
                  _usernameController.text = data.userName.toUpperCase();
                  _passwordController.text = data.password;
                }),
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
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  void goToHome(LoginResponseDto data) async {
    try {
      var newAcc = UserAccount(
          userName: _usernameController.text,
          password: _passwordController.text,
          timeCreated: DateTime.now());

      var index = userAccounts.indexWhere(
          (s) => s.userName.toLowerCase() == newAcc.userName.toLowerCase());

      if (index != -1) {
        var acc = userAccounts[index];
        if (acc.password == newAcc.password) {
          newAcc = null;
        }
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(account: newAcc)),
      );
    } catch (ex) {
      print(ex);
    }
  }

  bool isBusy = false;

  void loginAction() async {
    if (isBusy) {
      return;
    }
    isBusy = true;
    try {
      var data = await AuthorizationService().login(
          LoginResquestDto(_usernameController.text, _passwordController.text));

      if (data != null) {
        goToHome(data);
      }

      isBusy = false;
    } on Exception catch (ex) {
      AlertPopup().messageAlertPress(
          context, ex.toString().replaceAll("Exception: ", ""));

      isBusy = false;
    }
  }

  pageLoadFinish(BuildContext context) {
    loadAccountsLocal();
  }

  List<UserAccount> getSuggestions(String query) {
    List<UserAccount> matches = List();
    try {
      matches.addAll(userAccounts);

      matches.retainWhere(
          (s) => s.userName.toLowerCase().contains(query.toLowerCase()));

      if (matches?.length == 1) {
        var item = matches[0];
        if (item.userName.toLowerCase() == query.toLowerCase()) {
          matches.clear();
        }
      }
    } catch (ex) {
      print(ex);
    }
    return matches.reversed.toList();
  }

  void removeAccount(UserAccount account) {
    try {
      FocusScope.of(context).unfocus();

      var dbService = DatabaseService();
      dbService.deleteData(account);

      userAccounts.removeWhere((s) =>
          s.userName.toLowerCase().contains(account.userName.toLowerCase()));

      loadAccountsLocal();
    } catch (ex) {
      print(ex);
    }
  }

  void loadAccountsLocal() {
    try {
      var dbService = DatabaseService();
      dbService
          .getData<UserAccount>(UserAccount())
          .then((List<UserAccount> data) {
        userAccounts = data;
      });
    } catch (ex) {
      print(ex);
    }
  }
}
