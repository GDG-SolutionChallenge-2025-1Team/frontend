import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:provider/provider.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/learning_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DailyStudyScreen2 extends StatelessWidget {
  final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  DailyStudyScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LearningProvider>(
          builder: (context, learningProvider, child) {
        final audioPlayer = AudioPlayer();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          webViewController.loadRequest(
            Uri.parse(learningProvider.currentStudy?.wordSignUrl ?? ''),
          );
        });

        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.mainYellow),
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
                  '${learningProvider.currentDay}일차',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    learningProvider.word,
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'BMJUA',
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: 300,
                    height: 200,
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        learningProvider.currentStudy?.wordMediaUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: WebViewWidget(controller: webViewController),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    audioPlayer.play(
                      UrlSource(
                          learningProvider.currentStudy?.wordSoundUrl ?? ''),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/icon_sound.png',
                    width: 70,
                    height: 70,
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
                  Navigator.pushNamed(context, AppRoutes.dailyStudy3);
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
        );
      }),
    );
  }
}
