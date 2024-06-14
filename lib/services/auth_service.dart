import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

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

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return AuthTokens.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login.');
  }
}

Future<AuthTokens> registerService(String firstName, String lastName, String email, String password) async {
  final response = await http.post(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/auth/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "role": "USER"
    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return AuthTokens.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to register.');
  }
}

class AuthTokens{
  final String accessToken;
  final String refreshToken;

  AuthTokens({required this.accessToken, required this.refreshToken});

  factory AuthTokens.fromJson(Map<String, dynamic> json){
    return switch (json) {
      {
      'access_token' : String accessToken,
      'refresh_token' : String refreshToken
      } =>
        AuthTokens(
          accessToken: accessToken,
          refreshToken: refreshToken
        ),
    _ => throw const FormatException('Failed to get tokens'),
    };
  }
}
