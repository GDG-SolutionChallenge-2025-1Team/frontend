import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:provider/provider.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/learning_provider.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/word_item.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DailyStudyScreen4 extends StatefulWidget {
  const DailyStudyScreen4({super.key});

  @override
  State<DailyStudyScreen4> createState() => _DailyStudyScreen4State();
}

class _DailyStudyScreen4State extends State<DailyStudyScreen4> {
  WordItem? selectedWord;
  final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LearningProvider>(
        builder: (context, learningProvider, child) {
          learningProvider.updateLearningData();
          final sentence = learningProvider.sentence;
          final words = learningProvider.currentStudy?.words ?? [];

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
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 300,
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
                          learningProvider.currentStudy?.sentenceImageUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 6,
                      runSpacing: 6,
                      children: sentence.split(' ').map((word) {
                        final matched = words.firstWhere(
                          (w) => word.contains(w.word),
                          orElse: () => WordItem(word: '', wordMediaUrl: ''),
                        );

                        final isMatched = matched.word.isNotEmpty;

                        return GestureDetector(
                          onTap: isMatched
                              ? () {
                                  setState(() {
                                    selectedWord = matched;
                                    _webViewController.loadRequest(
                                      Uri.parse(matched.wordSignUrl ?? ''),
                                    );
                                  });
                                }
                              : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isMatched
                                  ? AppColors.textPink.withAlpha(180)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              word,
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'BMJUA',
                                color: AppColors.textBlack,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                color: AppColors.buttonYellow,
                                borderRadius: BorderRadius.circular(45),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _audioPlayer.play(
                                  UrlSource(learningProvider
                                          .currentStudy?.sentenceSoundUrl ??
                                      ''),
                                );
                              },
                              child: Image.asset(
                                'assets/icons/icon_review.png',
                                height: 95,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                color: AppColors.buttonYellow,
                                borderRadius: BorderRadius.circular(45),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/icons/icon_sign.png',
                              height: 95,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (selectedWord != null)
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(
                      color: AppColors.textPink,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                selectedWord!.word,
                                style: TextStyle(
                                  fontSize: 40,
                                  color: AppColors.textBlack,
                                  fontFamily: 'BMJUA',
                                ),
                              ),
                              SizedBox(height: 30),
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        selectedWord!.wordMediaUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -30,
                                    child: GestureDetector(
                                      onTap: () {
                                        _audioPlayer.play(
                                          UrlSource(
                                              selectedWord!.wordSoundUrl ?? ''),
                                        );
                                      },
                                      child: Image.asset(
                                        'assets/icons/icon_sound.png',
                                        width: 70,
                                        height: 70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              SizedBox(
                                width: 300,
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: WebViewWidget(
                                    controller: _webViewController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedWord = null;
                              });
                            },
                            child: Icon(Icons.close,
                                color: AppColors.textBlack, size: 28),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // 이전 / 다음 버튼
              Positioned(
                bottom: 30,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    learningProvider.goToPreviousPage();
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
                    learningProvider.goToNextPage(() {
                      Navigator.pushNamed(context, AppRoutes.dailyStudy5);
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
        },
      ),
    );
  }
}
