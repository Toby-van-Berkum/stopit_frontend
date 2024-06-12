import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/globals.dart';
import 'package:stopit_frontend/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                "First Name",
                style: AppStyles.labelStyle()
              ),
              const SizedBox(height: 8),
              TextField(
                // controller: _emailController,
                decoration: AppStyles.inputStyle("First Name")
              ),
              const SizedBox(height: 16),
              Text(
                "Last Name",
                style: AppStyles.labelStyle()
              ),
              const SizedBox(height: 8),
              TextField(
                // controller: _emailController,
                decoration: AppStyles.inputStyle("Last Name")
              ),
              const SizedBox(height: 16),
              Text(
                "Email",
                style: AppStyles.labelStyle()
              ),
              const SizedBox(height: 8),
              TextField(
                // controller: _emailController,
                decoration: AppStyles.inputStyle("Email")
              ),
              const SizedBox(height: 16),
              Text(
                "Password",
                style: AppStyles.labelStyle()
              ),
              const SizedBox(height: 8),
              TextField(
                // controller: _passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: AppStyles.inputStyle("Password")
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(title: AppTitle.title,)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // Background color
                  minimumSize: const Size(400, 50), // Width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rectangular shape
                  ),
                ),
                child: const Align(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20 // Bold text
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

