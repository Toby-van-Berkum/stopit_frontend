import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StatsTO {
  final double moneySaved;
  final int currentStreak;
  final int longestStreak;
  final int healthLevel;

  StatsTO({
    required this.moneySaved,
    required this.currentStreak,
    required this.longestStreak,
    required this.healthLevel
  });

  factory StatsTO.fromJson(Map<String, dynamic> json) {
    return StatsTO(
      moneySaved: json['moneySaved'].toDouble(),
      currentStreak: json['currentStreak'],
      longestStreak: json['longestStreak'],
      healthLevel: json['healthLevel'],
    );
  }
}

Future<StatsTO> fetchStats() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString("email");
  String? authToken = prefs.getString("accessToken");

  if (email == null) {
    throw Exception('Email is null');
  } else if (authToken == null) {
    throw Exception('AuthToken is null');
  }

  final response = await http.get(
    Uri.parse('https://stopit.onrender.com/stop-it/v1/stats/$email'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return StatsTO.fromJson(responseData);
  } else {
    throw Exception('Failed to load stats');
  }
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
    StatsTO stats = await fetchStats();

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
