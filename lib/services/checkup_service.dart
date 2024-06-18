import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

class CheckupTransferObject {
  final bool hasSmoked;
  final String comment;
  final String difficultyScale;
  final DateTime date;

  CheckupTransferObject({
    required this.hasSmoked,
    required this.comment,
    required this.difficultyScale,
    required this.date
  });

  factory CheckupTransferObject.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'hasSmoked': bool hasSmoked,
      'comment': String comment,
      'difficultyScale': String difficultyScale,
      'date': String date
      } =>
          CheckupTransferObject(
              hasSmoked: hasSmoked,
              comment: comment,
              difficultyScale: difficultyScale,
              date: DateTime.parse(date)
          ),
      _ => throw const FormatException('Failed to load day.'),
    };
  }
}

Future<List<CheckupTransferObject>> fetchCheckup(String authToken, String email) async {
  final response = await http.get(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/checkup/$email'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
  );

  final List<dynamic> responseJson = jsonDecode(response.body);
  return responseJson.map((json) => CheckupTransferObject.fromJson(json)).toList();
}



Future<http.Response> createCheckup(String authToken, bool hasSmoked, String comment, String difficultyScale, DateTime date) {
  return http.post(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/user/users/checkup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
    body: jsonEncode(<String, String>{
      'hasSmoked': hasSmoked.toString(),
      'comment': comment,
      'difficultyScale': difficultyScale,
      'date': date.toIso8601String()
    }),
  );
}