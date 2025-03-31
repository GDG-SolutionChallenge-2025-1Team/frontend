import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/calendar/calendar_screen.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/review/review_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/home/home_screen.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/settings/settings_screen.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/start/start_screen.dart';

import "./provider/calendar_provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: '고사리',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalendarProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
        AppRoutes.settings: (context) => SettingsScreen(),
        AppRoutes.calendar: (context) => CalendarScreen(),
        AppRoutes.review: (context) => ReviewScreen(),
      },
    );
  }
}
