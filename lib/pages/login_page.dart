import 'package:flutter/material.dart';
import 'package:stopit_frontend/pages/dashboard_page.dart';
import 'package:stopit_frontend/pages/register_page.dart';
import 'package:stopit_frontend/services/auth_service.dart';
import '../globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        AuthTokens tokens = await loginService(_emailController.text, _passwordController.text);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', tokens.accessToken);
        await prefs.setString('refreshToken', tokens.refreshToken);
        await prefs.setString('email', _emailController.text);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(title: AppTitle.title),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: $e')),
        );
      }
    }
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    if (accessToken != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPage(title: AppTitle.title),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: AppStyles.labelStyle()),
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
                Text("Login", style: AppStyles.headerStyle()),
                CustomSizedBox.large(),
                Text("Email", style: AppStyles.labelStyle()),
                CustomSizedBox.small(),
                TextFormField(
                  controller: _emailController,
                  decoration: AppStyles.inputStyle("Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                CustomSizedBox.medium(),
                Text("Password", style: AppStyles.labelStyle()),
                CustomSizedBox.small(),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: AppStyles.inputStyle("Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                CustomSizedBox.large(),
                LargeButton(
                  buttonLabel: "Login",
                  onPressed: _login,
                ),
                Row(
                  children: [
                    const Text("Don't have an account yet?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(title: AppTitle.title),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
