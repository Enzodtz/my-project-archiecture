import 'package:frontend/constants/shared_preferences.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/api_helper.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static const String LOGIN_PATH = '/auth/token/';

  static Future<User> login(Map<String, dynamic> form) async {
    final http.Response response = await ApiHelper.request(
      path: '/auth/token/',
      requestFunction: http.post,
      body: form,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jwt = jsonDecode(response.body);
        User user = User.fromJwt(jwt);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            SharedPreferencesConstants.ACCESS_TOKEN, user.accessToken);
        await prefs.setString(
            SharedPreferencesConstants.REFRESH_TOKEN, user.refreshToken);

        return user;
      case 401:
        throw Exception('Invalid username or password!');
      default:
        throw Exception('Failed to contact the server.');
    }
  }

  static Future<User> read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = await prefs.getString('accessToken');
    String? refreshToken = await prefs.getString('refreshToken');

    if (accessToken != null && refreshToken != null) {
      User user = User.fromJwt({
        'access': accessToken,
        'refreshToken': refreshToken,
      });

      return user;
    } else {
      throw Exception('No previous user.');
    }
  }

  static void refreshTokenIfNeeded(User? user) async {
    if (user != null) {
      if (JwtDecoder.isExpired(user.accessToken)) {
        if (JwtDecoder.isExpired(user.accessToken)) {
          throw Exception(
            'Your login has expired! Please close the app and try again.',
          );
        } else {
          final http.Response response = await http.post(
            ApiHelper.buildUri('/auth/token/refresh/'),
            headers: ApiHelper.buildHeaders(),
            body: jsonEncode({
              'refresh': user.refreshToken,
            }),
          );

          if (response.statusCode != 200) {
            throw Exception(
              'Failed to contact the server.',
            );
          }
        }
      }
    }
  }
}
