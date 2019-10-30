
import '../SQLFunction.dart';

class UserAccount implements SQLFunction{
  final String userName;
  final String password;

  UserAccount({this.userName, this.password});

  @override
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'password': password
    };
  }

  @override
  String toTableSQL() {
    return "CREATE TABLE UserAccounts(userName TEXT PRIMARY KEY, password TEXT)";
  }

  @override
  String getNameTableSQL() {
    return "UserAccounts";
  }

  @override
  UserAccount fromJson(Map<String, dynamic> json) {
    return UserAccount(
      userName: json['userName'] as String,
      password: json['password'] as String);
  }

  @override
  String getPrimaryKey() {
    return "userName";
  }

  @override
  dynamic getValuePrimaryKey() {
    return userName;
  }



//    var fido = UserAccount(
//      userName: "Biz00018",
//      password: "123456"
//    );

//    await createTable(fido);

//    await insertData(fido);
//
//    var data = await getData<UserAccount>(fido);
//    print(data[0].password);
//
//    fido = UserAccount(
//      userName: fido.userName,
//      password: "okokoko"
//    );
//
//    await insertData(fido);
//
//    // Print Fido's updated information.
//    data = await getData<UserAccount>(fido);
//    print(data[0].password);
//
//    // Delete Fido from the database.
//    await deleteData(fido);
//
//    // Print the list of dogs (empty).
//    data = await getData<UserAccount>(fido);
//    print(data);


}