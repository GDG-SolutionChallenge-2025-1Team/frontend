import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:provider/provider.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/learning_provider.dart';

class DailyStudyScreen1 extends StatefulWidget {
  const DailyStudyScreen1({super.key});

  @override
  State<DailyStudyScreen1> createState() => _DailyStudyScreen1State();
}

class _DailyStudyScreen1State extends State<DailyStudyScreen1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LearningProvider>(
        builder: (context, learningProvider, child) {
          return Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(color: AppColors.mainYellow)),
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
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    learningProvider.resetCurrentPage();
                    Navigator.pushNamed(context, AppRoutes.home);
                  },
                  child: const Text(
                    '고사리',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainYellow,
                      fontFamily: 'BMJUA',
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
                    '${learningProvider.currentDay}일차',
                    style: const TextStyle(
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
                child: const Center(
                  child: Text(
                    '지금은\n단어를\n배우는 시간!',
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
                  onTap: () async {
                    await learningProvider.changePage(
                        forward: false,
                        onNavigation: () {
                          Navigator.pop(context);
                        });
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
                    learningProvider.changePage(
                        forward: true,
                        onNavigation: () {
                          Navigator.pushNamed(context, AppRoutes.dailyStudy2);
                        });
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
                    '${learningProvider.currentStudy?.page ?? 1}',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BMJUA',
                      color: AppColors.mainSkyBlue,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
