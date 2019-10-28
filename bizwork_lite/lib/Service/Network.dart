
import 'dart:convert';
import 'dart:io';

class Network {
  final String url;

  Network(this.url);

  Future postData(Map<String, String> body) async {
    print('API URL: $url');

    HttpClient httpClient = new HttpClient();

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));

    print('API Request: $body');

    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print('API Response: $reply');
    return reply;
  }

}
