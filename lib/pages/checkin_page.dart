import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/dashboard_page.dart';
import '../globals.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key, required this.title});

  final String title;

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

const List<String> difficultyLevels = <String>[
  "Very Hard",
  "Hard",
  "Medium",
  "Easy",
  "Very Easy"
];

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
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  String? _comment;
  bool? _hasSmokedValue;
  String? _difficultyValue;

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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomSizedBox.large(),
              Text("Daily Check Up", style: AppStyles.headerStyle()),
              CustomSizedBox.large(),
              Text("Did you smoke today?", style: AppStyles.labelStyle()),
              CustomSizedBox.small(),
              ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _hasSmoked.length; i++) {
                      _hasSmoked[i] = i == index;
                    }
                    _hasSmokedValue = index == 0;
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: AppColors.primaryColor,
                fillColor: AppColors.primaryColor,
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: _hasSmoked,
                children: hasSmoked,
              ),
              CustomSizedBox.medium(),
              Text("How did your day go?", style: AppStyles.labelStyle()),
              CustomSizedBox.small(),
              TextFormField(
                controller: _commentController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 7,
                maxLength: 512,
                decoration: AppStyles.inputStyle("Comment"),
              ),
              const SizedBox(height: 10),
              Text("How difficult was today?", style: AppStyles.labelStyle()),
              CustomSizedBox.small(),
              ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _difficulty.length; i++) {
                      _difficulty[i] = i == index;
                    }
                    _difficultyValue = difficultyLevels[index];
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: AppColors.primaryColor,
                fillColor: AppColors.primaryColor,
                constraints: BoxConstraints(
                  minHeight: 40.0,
                  minWidth: ScreenSizes.width(context) / 5.51,
                ),
                isSelected: _difficulty,
                children: difficulty,
              ),
              CustomSizedBox.large(),
              LargeButton(
                buttonLabel: "Submit",
                onPressed: () {
                  // Save the values
                  debugPrint('Comment: $_comment');
                  debugPrint('Has smoked: $_hasSmokedValue');
                  debugPrint('Difficulty: $_difficultyValue');
                  //TODO: Fix false value pass on (passes null when not null)

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardPage(title: AppTitle.title),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
