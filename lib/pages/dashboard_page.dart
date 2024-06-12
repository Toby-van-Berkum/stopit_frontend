import 'package:flutter/material.dart';
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
            Text('Hello user'),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(400, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Align(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Check in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Text('“When you quit smoking, you not only add years to your life '
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
