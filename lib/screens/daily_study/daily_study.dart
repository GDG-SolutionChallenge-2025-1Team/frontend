import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/learning_provider.dart';

class DailyStudyScreen extends StatefulWidget {
  const DailyStudyScreen({super.key});

  @override
  State<DailyStudyScreen> createState() => _DailyStudyScreenState();
}

class _DailyStudyScreenState extends State<DailyStudyScreen> {
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
                decoration: const BoxDecoration(
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
                top: 200,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '오늘의 주제!',
                        style: TextStyle(
                          fontSize: 40,
                          color: AppColors.textBrown,
                          fontFamily: 'BMJUA',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        learningProvider.mainEmotion,
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BMJUA',
                          color: AppColors.textPink,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 300,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.network(
                          learningProvider.emotionMediaUrl,
                          fit: BoxFit.cover,
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
                          Navigator.pushNamed(context, AppRoutes.dailyStudy1);
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
                    '${learningProvider.currentPage}',
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
