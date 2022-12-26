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
          'Here you\'ll be able to find information about the app and tricks.',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
