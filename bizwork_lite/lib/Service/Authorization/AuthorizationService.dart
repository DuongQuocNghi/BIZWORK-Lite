import 'dart:convert';

import 'package:bizwork_lite/Service/Dto/APIResponse.dart';

import 'AuthorizationRemoteSource.dart';
import 'Dto/LoginRequestDto.dart';
import 'Dto/LoginResponseDto.dart';

class AuthorizationService {
  Future<LoginResponseDto> login(LoginResquestDto input) async {
    var jsonData = await AuthorizationRemoteSource().login(input);
    var mapData = json.decode(jsonData);
    var apiData = APIResponse.fromJson(mapData);
    if (apiData.data != null){
      return LoginResponseDto.fromJson(apiData.data);
    }else{
      throw new Exception(apiData.returnMessage);
    }
  }
}
