import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() async {
  await setPreferredOrientations();

  runApp(
    const ProviderScope(child: App()),
  );
}

Future<void> setPreferredOrientations() async {
  WidgetsFlutterBinding.ensureInitialized();

  return await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
