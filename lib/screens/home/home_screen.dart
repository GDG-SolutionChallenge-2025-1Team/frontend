import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.mainYellow,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.4),
              painter: WavePainter(
                color: AppColors.mainSkyBlue,
                isTopWave: true,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              '고사리',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.mainYellow,
                fontFamily: 'BMJUA',
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/image_bear.png',
                  fit: BoxFit.cover,
                  height: 350,
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    _buildMenuItem('assets/icons/icon_daily_study.png',
                        "오늘의 학습", AppRoutes.dailyStudy, context),
                    _buildMenuItem('assets/icons/icon_review.png', "발음 복습하기",
                        AppRoutes.review, context),
                    _buildMenuItem('assets/icons/icon_calendar.png', "달력 보기",
                        AppRoutes.calendar, context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      String imagePath, String label, String routeName, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: AppColors.buttonYellow,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'BMJUA',
                  color: AppColors.textBrown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
