import '../Network.dart';
import 'Dto/LoginRequestDto.dart';

const String apiHost = 'http://125.212.252.106:1003';
const String urlService = '/BizServiceWS.svc/api';
const String endPoint = '$apiHost$urlService';

class AuthorizationRemoteSource {

  Future<dynamic> login(LoginResquestDto input) async {
    var url = endPoint+'/login';
    Network network = Network(url);
    var catData = await network.postData(input.toJson());
    return catData;
  }

}
