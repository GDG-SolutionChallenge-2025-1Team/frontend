import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/home/home_screen.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/settings/settings_screen.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/start/start_screen.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/daily_study/daily_study.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/daily_study/daily_study_1.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/daily_study/daily_study_2.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/daily_study/daily_study_3.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/daily_study/daily_study_4.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/daily_study/daily_study_5.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/review/review.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/calendar/calendar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: '고사리',
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        AppRoutes.settings: (context) => SettingsScreen(),
        AppRoutes.dailyStudy: (context) => DailyStudyScreen(),
        AppRoutes.review: (context) => ReviewScreen(),
        AppRoutes.calendar: (context) => CalendarScreen(),
        AppRoutes.dailyStudy1: (context) => DailyStudyScreen1(),
        AppRoutes.dailyStudy2: (context) => DailyStudyScreen2(),
        AppRoutes.dailyStudy3: (context) => DailyStudyScreen3(),
        AppRoutes.dailyStudy4: (context) => DailyStudyScreen4(),
        AppRoutes.dailyStudy5: (context) => DailyStudyScreen5(),
      },
    );
  }
}
