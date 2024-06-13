import 'package:flutter/material.dart';
import 'globals.dart';

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
            Container(
              margin: EdgeInsets.only(
                  top: customPadding, bottom: customPadding * 2),
              child: Text('Users achievements',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),

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
            ),

            Container(
              margin: EdgeInsets.only(bottom: customPadding * 2),
              child: Text('“When you quit smoking, you not only add years to your life '
                  'but also life to your years”'),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: SingleCard(
                headText: 'No cigarettes',
                statsText: '2 months, 4 days',
                widthCard: (ScreenSizes.width(context)),
                colorCard: AppColors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
