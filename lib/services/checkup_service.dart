import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

class CheckupModel {
  final int id;
  final bool hasSmoked;
  final String comment;
  final int difficultyScale;
  final DateTime date;

  CheckupModel({
    required this.id,
    required this.hasSmoked,
    required this.comment,
    required this.difficultyScale,
    required this.date
  });

  factory CheckupModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'hasSmoked': bool hasSmoked,
      'comment': String comment,
      'difficultyScale': int difficultyScale,
      'time': DateTime date
      } =>
        CheckupModel(
          id: id,
          hasSmoked: hasSmoked,
          comment: comment,
          difficultyScale: difficultyScale,
          date: date
        ),
      _ => throw const FormatException('Failed to load day.'),
    };
  }
}

Future<CheckupModel> fetchCheckup(String authToken) async {
  final response = await http.get(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/checkup'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return CheckupModel.fromJson(responseJson);
}


Future<http.Response> createCheckup(String authToken, int id, bool hasSmoked, String comment, int difficultyScale, DateTime date) {
  return http.post(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
    body: jsonEncode(<String, String>{
      'id': id.toString(),
      'hasSmoked': hasSmoked.toString(),
      'comment': comment,
      'difficultyScale': difficultyScale.toString(),
      'date': date.toIso8601String()
    }),
  );
}

Future<http.Response> updateCheckup(String authToken, int id, bool hasSmoked, String comment, int difficultyScale, DateTime date) {
  return http.patch(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
    body: jsonEncode(<String, String>{
      'id': id.toString(),
      'hasSmoked': hasSmoked.toString(),
      'comment': comment,
      'difficultyScale': difficultyScale.toString(),
      'date': date.toIso8601String()
    }),
  );
}
