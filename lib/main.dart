import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game_type_screen.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
  startForegroundService();
}

void startForegroundService() async {
  ForegroundService().start();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Racquet Scorer',
      darkTheme: ThemeData(
        visualDensity: VisualDensity.compact,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const GameTypeScreen(),
    );
  }
}
