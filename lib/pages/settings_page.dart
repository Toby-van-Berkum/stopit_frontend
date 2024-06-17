import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../globals.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final double customPadding = 16.0;
  final int numberOfAchievements = 6; // dummy data, has to be changed
  List<String> source_links = [
    "https://stichtingstopbewust.nl/",
    "https://www.cancer.org/cancer/risk-prevention/tobacco/benefits-of-quitting-smoking-over-time.html",
    "https://www.ikstopnu.nl/",
    "https://www.thuisarts.nl/stoppen-met-roken/ik-wil-nu-stoppen-met-roken",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pages[currentPageIndex]),
          );
        },
        indicatorColor: AppColors.primaryColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.menu_book), label: "Journal"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(customPadding),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: customPadding,
                    right: customPadding,
                    bottom: customPadding),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: customPadding),
                child: LargeButton(
                    buttonLabel: "Change password",
                    onPressed: () {
                      return null;
                    }),
              ),
              LargeButton(
                  buttonLabel: "Log out",
                  onPressed: () {
                    return null;
                  }),
              Container(
                padding: EdgeInsets.only(
                    top: customPadding * 3,
                    right: customPadding,
                    bottom: customPadding),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sources',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ...List.generate(source_links.length, (i) {
                return LargeButton(
                    buttonLabel: 'source',
                    onPressed: () {
                      _launchUrl(
                          source_links[i]);
                    });
              }),
            ],
          ),
        ),
        // margin: EdgeInsets.all(customPadding),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final _url = Uri.parse(url);
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $_url');
  }
}


