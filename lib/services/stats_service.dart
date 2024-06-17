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

Future<StatsModel> fetchStats(String authToken, String email) async {
  final response = await http.get(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats/'+ email),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return StatsModel.fromJson(responseJson);
}


Future<http.Response> createStats(String authToken, int currentStreak, int healthLevel) {
  return http.post(
      Uri.parse('https://stopit.onrender.com/stop-it/v1/user/users/stats'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
    body: jsonEncode(<String, String>{
      'currentStreak': currentStreak.toString(),
      'healthLevel': healthLevel.toString()
    }),
  );
}

Future<http.Response> updateStats(String authToken, String email, int currentStreak, int healthLevel) {
  return http.patch(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats/'+email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
    body: jsonEncode(<String, String>{
      'currentStreak': currentStreak.toString(),
      'healthLevel': healthLevel.toString()
    }),
  );
}

Future<void> incrementStreak(String authToken, String email, int healthLevel) async {
  try {
    // Fetch the current stats
    StatsModel stats = await fetchStats(authToken, email);

    // Increment the current streak
    int newStreak = stats.currentStreak + 1;

    // Update the stats with the new streak value
    http.Response response = await updateStats(authToken, email, newStreak, healthLevel);

    if (response.statusCode == 200) {
      print("Streak updated successfully");
    } else {
      print("Failed to update streak: ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
  }
}

Future<void> resetStreak(String authToken, String email, int healthLevel) async {
  try {
    // Reset the current streak
    int newStreak = 0;

    // Update the stats with the new streak value
    http.Response response = await updateStats(authToken, email, newStreak, healthLevel);

    if (response.statusCode == 200) {
      print("Streak updated successfully");
    } else {
      print("Failed to update streak: ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
