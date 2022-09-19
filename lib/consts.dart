
import 'package:flutter/material.dart';

class DevelopmentRoutes{
  static Uri auth = Uri.http('192.168.1.6:8000', '/api/v1/auth/');
  static Uri categoryBalance = Uri.http('192.168.1.6:8000', '/api/v1/mocked_category_balance/');
}

class Http{
  static const int OK_200 = 200;
  static const int CREATED_201 = 201;
  static const int UNAUTHORIZED_401 = 401;
  static const int BAD_REQUEST_400 = 400;
  static const int ERROR_500 = 500;
  static const Map<String,String> headers = {'ContentType':'application/json'};
}

const COLORS = [Colors.red, Colors.amber, Colors.green, Colors.blue, Colors.black38, Colors.deepPurple];
