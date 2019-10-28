class LoginResquestDto {
  String userName;
  String password;

  LoginResquestDto(
    this.userName,
    this.password,
  );

  Map<String, String> toJson() {
    return {"UserName": userName, "Password": password};
  }
}
