import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopit_frontend/pages/login_page.dart';
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

  Future<void> _clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

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
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: "Journal"),
          NavigationDestination(icon: Icon(Icons.person_outlined), selectedIcon: Icon(Icons.person), label: "Profile"),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: "Settings")
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
                  onPressed: () async {
                    await _clearPreferences();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(title: AppTitle.title),
                      ),
                    );
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


