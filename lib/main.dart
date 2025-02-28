import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/home/home_screen.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/settings/settings_screen.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/start/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.start, // 시작 화면을 초기 라우트로 설정
      routes: {
        AppRoutes.start: (context) => StartScreen(),
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.settings: (context) => SettingsScreen()
      },
    );
  }
}
