import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopit_frontend/globals.dart';
import 'package:stopit_frontend/pages/login_page.dart';
import 'package:intl/intl.dart';
import 'package:stopit_frontend/services/stats_service.dart';

class RegisterPageForm extends StatefulWidget {
  const RegisterPageForm({super.key, required this.title});

  final String title;

  @override
  State<RegisterPageForm> createState() => _RegisterPageFormState();
}

class _RegisterPageFormState extends State<RegisterPageForm> {
  final _formKey = GlobalKey<FormState>();

  bool _hasQuit = false;

  DateTime? _quitDate;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final List<bool> _isSelected = [false, true]; // Initial state of toggle buttons
  final DateTime currentDay = DateTime.now();
  int streak = 0;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _quitDate) {
      setState(() {
        _quitDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                Text("Register", style: AppStyles.headerStyle(),),
                CustomSizedBox.large(),
                const Text(
                  "Before getting started we just need to ask you a couple questions to setup your account.",
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("How many cigarettes do you smoke a day?"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: AppStyles.inputStyle(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number';
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("How long have you been smoking (years)?"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: AppStyles.inputStyle(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of years';
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Have you already quit?"),
                    const SizedBox(height: 8),
                    ToggleButtons(
                      isSelected: _isSelected,
                      onPressed: (int index) {
                        setState(() {
                          // Update isSelected based on index
                          for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
                            _isSelected[buttonIndex] = buttonIndex == index;
                          }
                          // Update _hasQuit based on selected index
                          _hasQuit = _isSelected[0]; // true if index 0 is selected (Yes), false otherwise (No)
                        });
                      },
                      fillColor: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("Yes"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("No"),
                        ),
                      ],
                    ),
                  ],
                ),
                if (_hasQuit) ...[
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("When did you quit?"),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: AppStyles.inputStyle(
                              _quitDate == null
                                  ? "Enter date"
                                  : _dateFormat.format(_quitDate!),
                            ),
                            validator: (value) {
                              if (_quitDate == null) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                Center(
                  child:
                  LargeButton(
                    buttonLabel: 'Sign Up',
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      final authToken = prefs.getString("accessToken");

                      if (_formKey.currentState?.validate() ?? false) {
                        DateTime quitDate = _quitDate ?? DateTime(0);

                        if (_quitDate != null) {
                          streak = daysBetween(quitDate, currentDay);
                        }

                        createStats(authToken!, streak, "UNHEALTHY");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(
                              title: AppTitle.title,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
