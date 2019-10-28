
class LoginResponseDto {
  String loginSessionKey;
  String avatar;
  int employeeID;
  String employeeCode;
  String employeeType;
  String fullName;
  String lastName;
  String jobType;
  String lastActiveDate;
  String languageCode;
  int roleInTaskBelow;
  int sessionType;
  String deepLinkChatCS;

  LoginResponseDto(
      {this.loginSessionKey,
      this.avatar,
      this.employeeID,
      this.employeeCode,
      this.employeeType,
      this.fullName,
      this.lastName,
      this.jobType,
      this.lastActiveDate,
      this.languageCode,
      this.roleInTaskBelow,
      this.sessionType,
      this.deepLinkChatCS});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
        loginSessionKey: json['LoginSessionKey'] as String,
        avatar: json['Avatar'] as String,
        employeeID: json['EmployeeID'] as int,
        employeeCode: json['EmployeeCode'] as String,
        employeeType: json['EmployeeType'] as String,
        fullName: json['FullName'] as String,
        lastName: json['LastName'] as String,
        jobType: json['JobType'] as String,
        lastActiveDate: json['LastActiveDate'] as String,
        languageCode: json['LanguageCode'] as String,
        roleInTaskBelow: json['RoleInTaskBelow'] as int,
        sessionType: json['SessionType'] as int,
        deepLinkChatCS: json['DeepLinkChatCS'] as String);
  }
}

