import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme.dart';
import './screens/tabs_screen.dart';
import './providers/movies_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(moviesProvider.notifier).loadMovies();

    return MaterialApp(
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.theme,
      home: const SafeArea(child: TabsScreen()),
    );
  }
}
