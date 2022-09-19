import 'package:http/http.dart' as http;

import 'consts.dart';


class CustomClient extends http.BaseClient{

  static CustomClient client = CustomClient(Http.headers);

  final Map<String, String> headers;
  final http.Client _httpClient = http.Client();

  CustomClient(this.headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(headers);
    return _httpClient.send(request);
  }
}