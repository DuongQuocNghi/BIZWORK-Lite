import 'package:bizwork_lite/Db/DatabaseService.dart';
import 'package:bizwork_lite/Db/Mode/UserAccount.dart';
import 'package:bizwork_lite/Service/Authorization/AuthorizationService.dart';
import 'package:bizwork_lite/Service/Authorization/Dto/LoginRequestDto.dart';
import 'package:bizwork_lite/Service/Authorization/Dto/LoginResponseDto.dart';
import 'package:bizwork_lite/Widget/MyPopup.dart';
import 'package:bizwork_lite/Widget/AutoCompleteTextField.dart';
import 'package:bizwork_lite/Widget/GradientButton.dart';
import 'package:bizwork_lite/Widget/PasswordField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Home/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _iconLoading;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<UserAccount> userAccounts = List();

  set iconLoading(Widget value) {
    setState(() {
      _iconLoading = value;
    });
  }

  get isBusy {
    return _iconLoading != null ? true : false;
  }

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
              fieldKey: null,
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
            const SizedBox(height: 15.0),
            Center(
              child: Container(
                width: 20,
                height: 20,
                child: _iconLoading,
              ),
            ),
            Text(_batteryLevel),
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

  var platform = const MethodChannel('com.example.bizwork_lite/platform_view');
  var settingView = 'switchSettingView';

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _launchPlatformSetting() async {
    try {
      final result = await platform.invokeMethod(settingView);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void loginAction() async {
    _launchPlatformSetting();
    return;
    if (isBusy) {
      return;
    }

    iconLoading = CircularProgressIndicator(strokeWidth: 2);

    try {
      var data = await AuthorizationService().login(
          LoginResquestDto(_usernameController.text, _passwordController.text));

      if (data != null) {
        goToHome(data);
      }
      iconLoading = null;
    } on Exception catch (ex) {
      Future.delayed(Duration(milliseconds: 500)).then((_) {
        iconLoading = null;
      });
      MyPopup().messageAlertPress(
          context, ex.toString().replaceAll("Exception: ", ""));
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
