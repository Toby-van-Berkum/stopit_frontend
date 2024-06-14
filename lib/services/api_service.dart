import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<CheckupModel> fetchCheckupModel() async {
  final response = await http.get(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/checkup'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
    },
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return CheckupModel.fromJson(responseJson);
}

Future<StatsModel> fetchStatsModel() async {
  final response = await http.get(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
    },
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return StatsModel.fromJson(responseJson);
}

class CheckupModel {
  final int id;
  final bool hasSmoked;
  final String comment;
  final int difficultyScale;
  final DateTime time;

  CheckupModel({
    required this.id,
    required this.hasSmoked,
    required this.comment,
    required this.difficultyScale,
    required this.time
  });

  factory CheckupModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'hasSmoked': bool hasSmoked,
      'comment': String comment,
      'difficultyScale': int difficultyScale,
      'time': DateTime time
      } =>
        CheckupModel(
          id: id,
          hasSmoked: hasSmoked,
          comment: comment,
          difficultyScale: difficultyScale,
          time: time
        ),
      _ => throw const FormatException('Failed to load day.'),
    };
  }
}

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
