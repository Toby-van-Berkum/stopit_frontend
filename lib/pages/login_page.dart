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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(
        widget.title,
        style: AppStyles.labelStyle()
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: CustomBoxHeights.large,),
            Text("Login", style: AppStyles.headerStyle(),),
            const SizedBox(height: CustomBoxHeights.large,),
            Text(
              "Email",
              style: AppStyles.labelStyle()
            ),
            const SizedBox(height: CustomBoxHeights.small),
            TextField(
              controller: _emailController,
              decoration: AppStyles.inputStyle("Email")
            ),
            const SizedBox(height: CustomBoxHeights.medium),
            Text(
              "Password",
              style: AppStyles.labelStyle()
            ),
            const SizedBox(height: CustomBoxHeights.small),
            TextField(
              controller: _passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: AppStyles.inputStyle("Password")
            ),
            const SizedBox(height: CustomBoxHeights.large),
            LargeButton(buttonLabel: "Login", onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardPage(title: AppTitle.title)),
              );
            },),
            Row(
              children: [
                const Text("Don't have an account yet?"),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage(title: AppTitle.title,)));
                } ,
                    child: const Text('Register', style: TextStyle(color: AppColors.primaryColor),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
