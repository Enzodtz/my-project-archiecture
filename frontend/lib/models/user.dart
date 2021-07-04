import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  int id;
  String username;
  String accessToken;
  String refreshToken;

  User({
    required this.id,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  });

  factory User.fromJwt(Map<String, dynamic> jwt) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(jwt['access']);

    return User(
        id: decodedToken['id'],
        username: decodedToken['username'],

        // tokens
        accessToken: jwt['access'],
        refreshToken: jwt['refresh']);
  }
}
