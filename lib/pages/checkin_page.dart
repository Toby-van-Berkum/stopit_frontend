import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopit_frontend/pages/dashboard_page.dart';
import 'package:stopit_frontend/services/checkup_service.dart';
import 'package:stopit_frontend/services/stats_service.dart';
import '../globals.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key, required this.title});

  final String title;

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

const List<String> difficultyScale = <String>[
  'VERY_HARD',
  'HARD',
  'MEDIUM',
  'EASY',
  'VERY_EASY'
];

const List<Widget> hasSmoked = <Widget>[
  Text("Yes"),
  Text("No")
];

const List<Widget> difficulty = <Widget>[
  Text("Very\nHard"),
  Text("Hard"),
  Text("Medium"),
  Text("Easy"),
  Text("Very\nEasy")
];

class _CheckInPageState extends State<CheckInPage> {
  final List<bool> _hasSmoked = <bool>[false, true];
  final List<bool> _difficulty = <bool>[false, false, true, false, false];
  bool vertical = false;
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  String? _comment = "";
  bool? _hasSmokedValue = false;
  int? _difficultyValue = 2; // Default to "Medium"
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _commentController.addListener(() {
      setState(() {
        _comment = _commentController.text;
      });
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                    minHeight: 48.0,
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
                      _difficultyValue = index;
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: AppColors.primaryColor,
                  fillColor: AppColors.primaryColor,
                  constraints: BoxConstraints(
                    minHeight: 48.0,
                    minWidth: ScreenSizes.width(context) / 5.7,
                  ),
                  isSelected: _difficulty,
                  children: difficulty,
                ),
                CustomSizedBox.large(),
                LargeButton(
                  buttonLabel: "Submit",
                  onPressed: () async {
                    _currentDate = DateTime.now();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('lastCheckup', _currentDate.day);
                    String? authToken = prefs.getString('accessToken');
                    String? email = prefs.getString('email');

                    createCheckup(
                        authToken!,
                        _hasSmokedValue!,
                        _commentController.text,
                        difficultyScale[_difficultyValue!],
                        _currentDate);
                    if(_hasSmokedValue!){
                      resetStreak(authToken, email!, "UNHEALTHY");
                      debugPrint('reset');
                    } else {
                      incrementStreak(authToken, email!, "UNHEALTHY");
                      debugPrint('increment');
                    }
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
      ),
    );
  }
}
