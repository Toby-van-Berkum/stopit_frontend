import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/dashboard_page.dart';
import 'globals.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key, required this.title});

  final String title;

  @override
  State<CheckInPage> createState() => _CheckInPageState();
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
class _CheckInPageState extends State<CheckInPage> {
  final List<bool> _hasSmoked = <bool>[true, false];
  final List<bool> _difficulty = <bool>[false, false, true, false, false];
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
            Text("Daily Check Up", style: AppStyles.headerStyle(),),
            const SizedBox(height: CustomBoxHeights.large),
            Text("Did you smoke today?", style: AppStyles.labelStyle(),),
            const SizedBox(height: CustomBoxHeights.small),
            ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index){
                setState(() {
                  for(int i = 0; i < _hasSmoked.length; i++) {
                    _hasSmoked[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: AppColors.primaryColor,
              fillColor: AppColors.primaryColor,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0
              ),
              isSelected: _hasSmoked,
              children: hasSmoked,
            ),
            const SizedBox(height: CustomBoxHeights.medium),
            Text("How did your day go?", style: AppStyles.labelStyle(),),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 7,
              maxLength: 512,
              decoration: AppStyles.inputStyle("Comment"),
            ),
            const SizedBox(height: 10),
            Text("How difficult was today?", style: AppStyles.labelStyle(),),
            const SizedBox(height: CustomBoxHeights.small),
            ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index){
                setState(() {
                  for(int i = 0; i < _difficulty.length; i++) {
                    _difficulty[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: AppColors.primaryColor,
              fillColor: AppColors.primaryColor,
              constraints: BoxConstraints(
                  minHeight: 40.0,
                  minWidth: ScreenSizes.width(context)/5.51
              ),
              isSelected: _difficulty,
              children: difficulty,
            ),
            const SizedBox(height: CustomBoxHeights.large),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage(title: AppTitle.title,)));
              },
              style: AppStyles.largeButton(context),
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Submit',
                    style: AppStyles.labelStyle()
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
