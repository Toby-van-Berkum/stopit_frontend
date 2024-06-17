import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopit_frontend/pages/checkin_page.dart';
import 'package:stopit_frontend/pages/profile_page.dart';
import 'package:stopit_frontend/pages/register_page.dart';
import '../globals.dart';
import 'package:stopit_frontend/services/stats_service.dart';
import 'package:stopit_frontend/services/auth_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.title});

  final String title;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

Future<String?> _getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

Future<String?> _getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken');
}

class _DashboardPageState extends State<DashboardPage> {
  final double customPadding = 16.0;
  //
  // Future<bool> dateChecker() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? lastCheckup = prefs.getInt('lastCheckup');
  //
  //   if(DateTime.now().day == lastCheckup){
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  final DateTime currentDay = DateTime.now();

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  void initState() {
    currentPageIndex = 0;
    super.initState();
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
              MaterialPageRoute(
                  builder: (context) => pages[currentPageIndex]
              ),
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
        child: Container(
          margin: EdgeInsets.all(customPadding),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: customPadding, bottom: customPadding * 2),
                child: Text('Hello user,',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Container(
                margin: EdgeInsets.only(bottom: customPadding * 3),
                child: LargeButton(buttonLabel: "Check In", onPressed: () /** async **/ {
                  // if(await dateChecker()) {
                  //   return null;
                  // }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CheckInPage(title: AppTitle.title,)));
                }),
              ),
              Container(
                margin: EdgeInsets.only(bottom: customPadding * 2),
                child: Text('“When you quit smoking, you not only add years to your life '
                    'but also life to your years”'),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: SingleCardStats(
                  headText: 'No cigarettes',
                  statsText: '$fetchStats(_getAuthToken(), _getEmail())',
                  widthCard: (ScreenSizes.width(context)),
                  colorCard: AppColors.yellow,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleCardStats(
                      headText: 'You saved',
                      statsText: '${fetchStats().toString()}',
                      widthCard:
                          ((ScreenSizes.width(context) / 2) - customPadding - 4),
                      colorCard: AppColors.blue),
                  SingleCardStats(
                      headText: 'Your health',
                      statsText: 'insert text',
                      widthCard:
                          ((ScreenSizes.width(context) / 2) - customPadding - 4),
                      colorCard: AppColors.green),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
