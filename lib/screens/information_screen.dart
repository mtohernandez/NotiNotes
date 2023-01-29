import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  static const routeName = '/information-screen';
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Manual'),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Still in development. Please wait for the next update.',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
