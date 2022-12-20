import 'package:flutter/material.dart';

class LoginSignupScreen extends StatelessWidget {
  static const routeName = '/login-signup';
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('No information yet.'),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
