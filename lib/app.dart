import 'package:flutter/material.dart';

import 'theme.dart';
import './screens/tabs_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.theme,
      home: const SafeArea(child: TabsScreen()),
    );
  }
}
