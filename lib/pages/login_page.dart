import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              const Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20 // Bold text
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                // controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20// Bold text
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                // controller: _passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Add your onPressed logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[200], // Background color
                  minimumSize: const Size(400, 50), // Width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rectangular shape
                  ),
                ),
                child: const Align(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Login',
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

