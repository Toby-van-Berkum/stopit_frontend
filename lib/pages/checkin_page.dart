import 'package:flutter/material.dart';
import 'globals.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key, required this.title});

  final String title;

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

enum HasSmoked { yes, no }
enum Difficulty {VERY_HARD,HARD,MEDIUM,EASY,VERY_EASY}

class _CheckInPageState extends State<CheckInPage> {
  HasSmoked? _answer = HasSmoked.yes;

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
              Text("Daily Check Up", style: AppStyles.headerStyle(),),
              Text("Did you smoke today?", style: AppStyles.labelStyle(),),
              ListTile(
                title: const Text('Yes'),
                leading: Radio<HasSmoked>(
                  value: HasSmoked.yes,
                  groupValue: _answer,
                  onChanged: (HasSmoked? value) {
                    setState(() {
                      _answer = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('No'),
                leading: Radio<HasSmoked>(
                  value: HasSmoked.no,
                  groupValue: _answer,
                  onChanged: (HasSmoked? value) {
                    setState(() {
                      _answer = value;
                    });
                  },
                ),
              ),
              Text("How did your day go?", style: AppStyles.labelStyle(),),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 7,
                maxLength: 512,
                decoration: AppStyles.inputStyle("Comment"),
              ),
              Text("How difficult was today?", style: AppStyles.labelStyle(),),
              OverflowBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton( child: const Text('1'), onPressed: () {}),
                  TextButton( child: const Text('2'), onPressed: () {}),
                  TextButton( child: const Text('3'), onPressed: () {}),
                  TextButton( child: const Text('4'), onPressed: () {}),
                  TextButton( child: const Text('5'), onPressed: () {})
                ],
              ),
              //TODO: Add "has Smoked" (yes/no) buttons
              //TODO: Add a comment field
              //TODO: Add difficulty scale (VERY_HARD,HARD,MEDIUM,EASY,VERY_EASY)
              ElevatedButton(onPressed: null, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
