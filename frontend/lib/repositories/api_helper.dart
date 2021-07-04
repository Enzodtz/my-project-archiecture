import 'dart:convert';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/user.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String scheme = 'http';
  static const String host = 'localhost';
  static const int port = 8000;

  static Uri buildUri(String path) {
    return Uri(
      scheme: scheme,
      host: host,
      path: path,
      port: port,
    );
  }

  static Map<String, String> buildHeaders({User? user}) {
    Map<String, String> headers = {
      "Accept": "application/json; charset=utf-8",
      "Content-Type": "application/json; charset=utf-8"
    };

    if (user != null) {
      headers['Authorization'] = 'Bearer ${user.accessToken}';
    }

    return headers;
  }

  static Future<http.Response> request({
    required String path,
    required Function requestFunction,
    required Map<String, dynamic> body,
    User? user,
  }) async {
    UserRepository.refreshTokenIfNeeded(user);

    final http.Response response = await requestFunction(
      ApiHelper.buildUri(path),
      headers: ApiHelper.buildHeaders(user: user),
      body: jsonEncode(body),
    );

    return response;
  }
}
