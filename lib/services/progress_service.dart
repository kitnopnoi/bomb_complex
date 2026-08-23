import 'package:shared_preferences/shared_preferences.dart';

int highestStage = 0;
int highScore = 0;
final Set<int> shownHowToStages = {};
bool shownEndlessTutorial = false;

Future<void> saveProgress() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('highestStage', highestStage);
  await prefs.setInt('highScore', highScore);
}

Future<void> loadProgress() async {
  final prefs = await SharedPreferences.getInstance();
  highestStage = prefs.getInt('highestStage') ?? 0;
  highScore = prefs.getInt('highScore') ?? 0;
}
