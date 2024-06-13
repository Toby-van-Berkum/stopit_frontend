import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/checkin_page.dart';
import 'package:stopit_frontend/pages/journal_day_page.dart';
import 'globals.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.title});

  final String title;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final double customPadding = 16.0;

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
      body: Container(
        margin: EdgeInsets.all(customPadding),
        child: Column(
          children: <Widget>[
            const Text('Hello user'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const JournalDayPage(title: AppTitle.title,)));
              },
              style: AppStyles.largeButton(context),
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                      'Check In',
                      style: AppStyles.labelStyle()
                  ),
                ),
              ),
            ),
            const Text('“When you quit smoking, you not only add years to your life '
                'but also life to your years”'),
            SingleCard(
                headText: 'No cigarettes',
                statsText: '2 months, 4 days',
                widthCard: (ScreenSizes.width(context)),
                colorCard: AppColors.yellow),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleCard(
                    headText: 'You saved',
                    statsText: '€30',
                    widthCard:
                        ((ScreenSizes.width(context) / 2) - customPadding - 4),
                    colorCard: AppColors.blue),
                SingleCard(
                    headText: 'Your health',
                    statsText: 'insert text',
                    widthCard:
                        ((ScreenSizes.width(context) / 2) - customPadding - 4),
                    colorCard: AppColors.green),
              ],
            )
          ],
        ),
      ),
    );
  }
}
