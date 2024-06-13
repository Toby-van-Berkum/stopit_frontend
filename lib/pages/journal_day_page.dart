import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/dashboard_page.dart';
import 'globals.dart';

class JournalDayPage extends StatefulWidget {
  const JournalDayPage({super.key, required this.title});

  final String title;

  @override
  State<JournalDayPage> createState() => _JournalDayPageState();
}

const List<Widget> hasSmoked = <Widget>[
  Text("Yes"),
  Text("No")
];
const List<Widget> difficulty = <Widget>[
  Text("Very Hard"),
  Text("Hard"),
  Text("Medium"),
  Text("Easy"),
  Text("Very Easy")
];
class _JournalDayPageState extends State<JournalDayPage> {
  bool vertical = false;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: CustomBoxHeights.large,),
            Text("Journal Entry", style: AppStyles.headerStyle(),),
            Text("23/04/2024", style: AppStyles.labelStyle(),),
            const SizedBox(height: CustomBoxHeights.large),
            Text("Did you smoke today?", style: AppStyles.labelStyle(),),
            const SizedBox(height: CustomBoxHeights.small),
            const Text("Yes/No"),
            const SizedBox(height: CustomBoxHeights.medium),
            Text("How did your day go?", style: AppStyles.labelStyle(),),
            const SizedBox(height: CustomBoxHeights.small),
            const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris egestas feugiat nunc sed finibus. Proin fermentum pretium odio, et lacinia nulla convallis a. Morbi dignissim vehicula tristique. Fusce eu convallis ante. Nullam congue convallis nibh a volutpat. Duis euismod lacus et est molestie, volutpat ultricies libero hendrerit. Aliquam malesuada sem sit amet condimentum consequat. "),
            const SizedBox(height: CustomBoxHeights.medium),
            Text("How difficult was today?", style: AppStyles.labelStyle(),),
            const SizedBox(height: CustomBoxHeights.small),
            const Text("Very Easy/Easy/Medium/Hard/Very Hard"),
          ],
        ),
      ),
    );
  }
}
