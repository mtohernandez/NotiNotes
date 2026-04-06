import 'package:flutter/material.dart';

/// Stubbed in Phase 4. Real implementation lands in Phase 6.
class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings coming soon')),
    );
  }
}
