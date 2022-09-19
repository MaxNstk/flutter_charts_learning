import 'dart:convert';

import 'package:charts_example/dafult_client.dart';
import 'consts.dart';

class LoginProvider{

  static Future<bool> performLogin(String username, String password) async {
    var response = await CustomClient.client.post(DevelopmentRoutes.auth,
        body: {'username': username, 'password': password}
    );
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (response.statusCode != Http.OK_200) {
      return false;
    }

    String token = decodedResponse['token'] as String;
    CustomClient.client = CustomClient({'ContentType':'application/json', 'Authorization' : 'Token $token'});
    return true;
    }
  }


