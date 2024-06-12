import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/checkin_page.dart';
import 'package:stopit_frontend/pages/dashboard_page.dart';
import 'package:stopit_frontend/pages/register_page.dart';
import 'globals.dart';

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
      title: Text(
        widget.title,
        style: const TextStyle(
        fontWeight: FontWeight.bold,
        ),
      ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Login", style: TextStyle(fontSize: 45),),
              const SizedBox(height: 50,),
              const Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                controller: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  filled: true,
                  fillColor: AppColors.accentColor
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                controller: null,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                    hintText: 'Password',
                  filled: true,
                  fillColor: AppColors.accentColor
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage(title: AppTitle.title,)));
                },
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
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const Text("Don't have an account yet?"),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage(title: AppTitle.title,)));
                  } ,
                      child: const Text('Stop It', style: TextStyle(color: AppColors.primaryColor),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
