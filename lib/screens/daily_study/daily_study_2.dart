import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';

class DailyStudyScreen2 extends StatelessWidget {
  const DailyStudyScreen2({super.key});

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
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: CustomPaint(
                painter: WavePainter(
                  color: AppColors.mainSkyBlue,
                  isTopWave: true,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '1일차',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPink,
                  fontFamily: 'BMJUA',
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '오늘의 주제!',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'BMJUA',
                      color: AppColors.textBrown,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '행복',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BMJUA',
                      color: AppColors.textPink,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.1416),
                child: Image.asset(
                  'assets/icons/icon_next_button.png',
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.dailyStudy1);
              },
              child: Image.asset(
                'assets/icons/icon_next_button.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '3',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BMJUA',
                  color: AppColors.mainSkyBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
