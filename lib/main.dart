import 'package:flutter/material.dart';
import 'services/progress_service.dart';
import 'pages/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadProgress();
  runApp(const BombComplexApp());
}

class BombComplexApp extends StatelessWidget {
  const BombComplexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bomb Complex',
      theme: ThemeData(useMaterial3: true),
      home: const MainMenu(),
    );
  }
}
