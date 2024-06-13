import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/globals.dart';
import 'package:stopit_frontend/pages/login_page.dart';
import 'package:intl/intl.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime.now(), // Latest date
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Before getting started we just need to ask you a couple questions to setup your account.",
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      flex: 2, // 2/3 of the row width
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Text(
                          "How many cigarettes do you smoke a day?",
                          softWrap: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 1, // 1/3 of the row width
                      child: TextFormField(
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
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      flex: 2, // 2/3 of the row width
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Text(
                          "How long have you been smoking (years)?",
                          softWrap: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 1, // 1/3 of the row width
                      child: TextFormField(
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
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      flex: 2, // 2/3 of the row width
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Text(
                          "Have you already quit?",
                          softWrap: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 1, // 1/3 of the row width
                      child: DropdownButtonFormField<bool>(
                        decoration: AppStyles.inputStyle(),
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text("Yes"),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text("No"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _hasQuit = value ?? false;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                if (_hasQuit) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        flex: 2, // 2/3 of the row width
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: Text(
                            "When did you quit?",
                            softWrap: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        flex: 1, // 1/3 of the row width
                        child: GestureDetector(
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
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
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
                  style: AppStyles.largeButton(context),
                  child: const Align(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20, // Bold text
                        ),
                      ),
                    ),
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
