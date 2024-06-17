import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopit_frontend/pages/login_page.dart';
import 'package:stopit_frontend/services/auth_service.dart';
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

  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> sourceLinks = {
      "stichtingstopbewust.nl": "https://stichtingstopbewust.nl/",
      "American Cancer Society":
          "https://www.cancer.org/cancer/risk-prevention/tobacco/benefits-of-quitting-smoking-over-time.html",
      "ikstopnu.nl": "https://www.ikstopnu.nl/",
      "thuisarts.nl":
          "https://www.thuisarts.nl/stoppen-met-roken/ik-wil-nu-stoppen-met-roken",
    };

    List<String> keysSourceLinks = sourceLinks.keys.toList();
    List<String> valuesSourceLinks = sourceLinks.values.toList();

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
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: "Journal"),
          NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: "Profile"),
          NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: "Settings")
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
                    backgroundColor: AppColors.yellow,
                    buttonLabel: "Change password",
                    onPressed: () {
                      return null;
                    }),
              ),
              LargeButton(
                  buttonLabel: "Log out",
                  backgroundColor: AppColors.red,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? authToken = prefs.getString('accessToken');
                    if (authToken != null) {
                      await logoutService(authToken);
                    }
                    prefs.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage(title: AppTitle.title),
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
              Container(
                padding: EdgeInsets.only(bottom: customPadding * 2),
                alignment: Alignment.centerLeft,
                child: Text(
                    "At Stop It, we believe that transparency is the cornerstone of building trust with our users. Our mission is to support you on your journey to quit smoking, and we are committed to providing clear, honest, and straightforward information about how our app works, what data we collect, and how we use it to enhance your experience."),
              ),
              ...List.generate(sourceLinks.length, (i) {
                return Padding(
                  padding: EdgeInsets.only(bottom: customPadding),
                  child: LargeButton(
                      buttonLabel: keysSourceLinks[i],
                      onPressed: () {
                        _launchUrl(valuesSourceLinks[i]);
                      }),
                );
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
