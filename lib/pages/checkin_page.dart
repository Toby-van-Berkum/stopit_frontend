import 'package:flutter/material.dart';
import 'globals.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key, required this.title});

  final String title;

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Daily Check Up"),
              //TODO: Add has Smoked (yes/no) buttons
              //TODO: Add a comment field
              //TODO: Add difficulty scale (VERY_HARD,HARD,MEDIUM,EASY,VERY_EASY)
              ElevatedButton(onPressed: null, child: Text("ur mum"))
            ],
          ),
        ),
      ),
    );
  }
}
