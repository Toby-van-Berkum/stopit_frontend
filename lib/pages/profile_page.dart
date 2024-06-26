import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopit_frontend/services/stats_service.dart';
import '../globals.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double customPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    Map<String, String> healthAchievementsExplanations = {
      '20 minutes after quitting': 'Your heart rate and blood pressure drop.',
      'A few days after quitting':
          'The carbon monoxide level in your blood drops to normal.',
      '2 weeks to 3 months after quitting':
          'Your circulation improves and your lung function increases.',
      '1 to 12 months after quitting':
          'Coughing and shortness of breath decrease. Tiny hair-like structures (called cilia)  that move mucus out of the lungs start to regain normal function,  increasing their ability to handle mucus, clean the lungs, and reduce  the risk of infection.',
      '1 to 2 years after quitting':
          'Your risk of heart attack drops dramatically.',
      '5 to 10 years after quitting':
          'Your risk of cancers of the mouth, throat, and voice box (larynx) is cut in half. Your stroke risk decreases.',
      '10 years after quitting':
          'Your risk of lung cancer is about half that of a person who is still  smoking (after 10 to 15 years). Your risk of cancer of the bladder,  esophagus, and kidney decreases.',
      '15 years after quitting':
          'Your risk of coronary heart disease is close to that of a non-smoker.',
    };

    List<String> keysHealthAchievementsExplanations =
        healthAchievementsExplanations.keys.toList();
    List<String> valuesHealthAchievementsExplanations =
        healthAchievementsExplanations.values.toList();

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
              FutureBuilder<StatsTO>(
                future: fetchStats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No data available');
                  } else {
                    final stats = snapshot.data!;
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: customPadding,
                              right: customPadding,
                              bottom: customPadding),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Your achievements',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleCardStats(
                              headText: 'Your longest streak was',
                              statsText: '${stats.longestStreak} days',
                              widthCard: (ScreenSizes.width(context) / 2) -
                                  customPadding -
                                  4,
                              colorCard: AppColors.primaryColor,
                            ),
                            SingleCardStats(
                              headText: "You haven't smoked for",
                              statsText: '${stats.currentStreak} days',
                              widthCard: (ScreenSizes.width(context) / 2) -
                                  customPadding -
                                  4,
                              colorCard: AppColors.green,
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: customPadding, bottom: customPadding * 2),
                          child: Text('Keep going! It’ll only get easier'),
                        ),
                        SingleCardStats(
                          headText: 'You saved',
                          statsText:
                              'Money Saved: ${stats.moneySaved.toStringAsFixed(2)}',
                          widthCard:
                              ScreenSizes.width(context) - customPadding - 4,
                          colorCard: AppColors.blue,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: customPadding * 4,
                            right: customPadding,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Your health',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        ...List.generate(
                            keysHealthAchievementsExplanations.length, (i) {
                          return Padding(
                            padding: EdgeInsets.only(top: customPadding),
                            child: SingleCardAchievementExplanation(
                                headText: keysHealthAchievementsExplanations[i],
                                statsText:
                                    valuesHealthAchievementsExplanations[i],
                                widthCard: ScreenSizes.width(context),
                                achievementCompleted: true),
                          );
                        }),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
        // margin: EdgeInsets.all(customPadding),
      ),
    );
  }
}
