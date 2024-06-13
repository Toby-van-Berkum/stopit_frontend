import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/globals.dart';
import 'package:stopit_frontend/pages/login_page.dart';

class RegisterPageForm extends StatefulWidget {
  const RegisterPageForm({super.key, required this.title});

  final String title;

  @override
  State<RegisterPageForm> createState() => _RegisterPageFormState();
}

class _RegisterPageFormState extends State<RegisterPageForm> {
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
                    flex: 3, // 2/3 of the row width
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
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: AppStyles.inputStyle()
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    flex: 3, // 2/3 of the row width
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
                    child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: AppStyles.inputStyle()
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    flex: 3, // 2/3 of the row width
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
                    child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: AppStyles.inputStyle()
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    flex: 3, // 2/3 of the row width
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
                    child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: AppStyles.inputStyle()
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(
                        title: AppTitle.title,
                      ),
                    ),
                  );
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
    );
  }
}
