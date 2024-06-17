import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

class StatsModel {
  final int id;
  final double moneySaved;
  final int currentStreak;
  final int longestStreak;
  final Enum healthLevel;

  StatsModel({
    required this.id,
    required this.moneySaved,
    required this.currentStreak,
    required this.longestStreak,
    required this.healthLevel
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'money saved': double moneySaved,
      'current streak': int currentStreak,
      'longest streak': int longestStreak,
      'health level': Enum healthLevel
      } =>
          StatsModel(
              id: id,
              moneySaved: moneySaved,
              currentStreak: currentStreak,
              longestStreak: longestStreak,
              healthLevel: healthLevel
          ),
      _ => throw const FormatException('Failed to load stats.'),
    };
  }
}

Future<StatsModel> fetchStats(String authToken) async {
  final response = await http.get(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return StatsModel.fromJson(responseJson);
}


Future<http.Response> createStats(String authToken, int id, double moneySaved, int currentStreak, int longestStreak, Enum healthLevel) {
  return http.post(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
    body: jsonEncode(<String, String>{
      'id': id.toString(),
      'money saved': moneySaved.toString(),
      'current streak': currentStreak.toString(),
      'longest streak': longestStreak.toString(),
      'health level': healthLevel.toString()
    }),
  );
}

Future<http.Response> updateStats(String authToken, int id, double moneySaved, int currentStreak, int longestStreak, Enum healthLevel) {
  return http.patch(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
    body: jsonEncode(<String, String>{
      'id': id.toString(),
      'money saved': moneySaved.toString(),
      'current streak': currentStreak.toString(),
      'longest streak': longestStreak.toString(),
      'health level': healthLevel.toString()
    }),
  );
}

