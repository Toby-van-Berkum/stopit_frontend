import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

const OK = 200;

class AuthTokens {
  final String accessToken;
  final String refreshToken;

  AuthTokens({required this.accessToken, required this.refreshToken});

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'access_token': String accessToken,
      'refresh_token': String refreshToken
      } =>
          AuthTokens(
              accessToken: accessToken,
              refreshToken: refreshToken
          ),
      _ => throw const FormatException('Failed to get tokens'),
    };
  }
}

Future<AuthTokens> loginService(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/auth/authenticate'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email": email,
      "password": password
    }),
  );

  print(response.body);
  var token = AuthTokens.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  if (token.accessToken == "INVALID" || token.refreshToken == "INVALID")
    throw Exception('The tokens are invalid!');

  if (response.statusCode == OK ) {
    return AuthTokens.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to login.');
  }
}

Future<void> logoutService(String authToken) async {
  await http.post(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/auth/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
  );
}

Future<AuthTokens> registerService(String firstName, String lastName, String email, String password) async {
  final response = await http.post(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/auth/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "password": password,
      "role": "USER"
    }),
  );
  if (response.statusCode == OK) {
    return AuthTokens.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to register.');
  }
}
