import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/learning_provider.dart';

class DailyStudyScreen2 extends StatefulWidget {
  const DailyStudyScreen2({super.key});

  @override
  State<DailyStudyScreen2> createState() => _DailyStudyScreen2State();
}

class _DailyStudyScreen2State extends State<DailyStudyScreen2> {
  final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final provider = Provider.of<LearningProvider>(context, listen: false);
      final signUrl = provider.currentStudy?.wordSignUrl;
      if (signUrl != null && signUrl.isNotEmpty) {
        webViewController.loadRequest(Uri.parse(signUrl));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LearningProvider>(
        builder: (context, learningProvider, child) {
          final study = learningProvider.currentStudy;
          final audioPlayer = AudioPlayer();

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(color: AppColors.mainYellow),
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
                    Navigator.pushNamed(context, AppRoutes.dailyStudy);
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      study?.word ?? '',
                      style: const TextStyle(
                        fontSize: 50,
                        fontFamily: 'BMJUA',
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: 300,
                      height: 200,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          study?.wordImageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Text('이미지 없음')),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: const BoxDecoration(
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
                        UrlSource(study?.wordSoundUrl ?? ''),
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
                  onTap: () async {
                    await learningProvider.changePage(
                      forward: false,
                      onNavigation: () {
                        final prevPage =
                            learningProvider.currentStudy?.page ?? 1;
                        Navigator.pushNamed(
                            context, getRouteForPage(prevPage, forward: false));
                      },
                    );
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
                  onTap: () async {
                    await learningProvider.changePage(
                      forward: true,
                      onNavigation: () {
                        final nextPage =
                            learningProvider.currentStudy?.page ?? 1;
                        Navigator.pushNamed(
                            context, getRouteForPage(nextPage, forward: false));
                      },
                    );
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

String getRouteForPage(int page, {required bool forward}) {
  if (page == 3) return forward ? AppRoutes.dailyStudy2 : AppRoutes.dailyStudy1;
  if (page == 4) return AppRoutes.dailyStudy2;
  if (page == 5) return forward ? AppRoutes.dailyStudy3 : AppRoutes.dailyStudy2;
  if (page == 6) return AppRoutes.dailyStudy3;
  if (page == 7) return AppRoutes.dailyStudy4;
  return AppRoutes.dailyStudy;
}
