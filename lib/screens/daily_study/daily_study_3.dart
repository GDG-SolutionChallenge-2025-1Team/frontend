import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:provider/provider.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/learning_provider.dart';

class DailyStudyScreen3 extends StatelessWidget {
  const DailyStudyScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final learningProvider = Provider.of<LearningProvider>(context);

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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '지금은\n문장을\n배우는 시간!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 60,
                  color: AppColors.textBrown,
                  fontFamily: 'BMJUA',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -50,
            child: SizedBox(
              child: ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/image_bear.png',
                    fit: BoxFit.cover,
                    height: 500,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: GestureDetector(
              onTap: () {
                learningProvider.decreasePage();
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
                learningProvider.goToNextPage();
                Navigator.pushNamed(context, AppRoutes.dailyStudy4);
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
                '${learningProvider.currentPage}',
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
