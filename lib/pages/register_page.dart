import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopit_frontend/globals.dart';
import 'package:stopit_frontend/pages/register_page_form.dart';
import 'package:stopit_frontend/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    print(_firstNameController.text);
    print(_lastNameController.text);
    if (_formKey.currentState?.validate() ?? false) {
      try {
        AuthTokens tokens = await registerService(
            _firstNameController.text,
            _lastNameController.text,
            _emailController.text,
            _passwordController.text);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', tokens.accessToken);
        await prefs.setString('refreshToken', tokens.refreshToken);
        await prefs.setString('email', _emailController.text);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterPageForm(title: AppTitle.title),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: $e')),
        );
      }
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
                Text("Register", style: AppStyles.headerStyle()),
                CustomSizedBox.large(),
                Text(
                  "First Name",
                  style: AppStyles.labelStyle(),
                ),
                CustomSizedBox.small(),
                TextFormField(
                  controller: _firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  decoration: AppStyles.inputStyle("First Name"),
                ),
                CustomSizedBox.medium(),
                Text(
                  "Last Name",
                  style: AppStyles.labelStyle(),
                ),
                CustomSizedBox.small(),
                TextFormField(
                  controller: _lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  decoration: AppStyles.inputStyle("Last Name"),
                ),
                CustomSizedBox.medium(),
                Text(
                  "Email",
                  style: AppStyles.labelStyle(),
                ),
                CustomSizedBox.small(),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: AppStyles.inputStyle("Email"),
                ),
                CustomSizedBox.medium(),
                Text(
                  "Password",
                  style: AppStyles.labelStyle(),
                ),
                CustomSizedBox.small(),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // You can add more password validation if needed
                    return null;
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: AppStyles.inputStyle("Password"),
                ),
                CustomSizedBox.large(),
                LargeButton(
                  buttonLabel: "Next",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Navigate to next page or perform further actions
                      _register();
                    }
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
