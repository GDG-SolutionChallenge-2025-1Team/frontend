import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/learning_provider.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/word_item.dart';

class DailyStudyScreen4 extends StatefulWidget {
  const DailyStudyScreen4({super.key});

  @override
  State<DailyStudyScreen4> createState() => _DailyStudyScreen4State();
}

class _DailyStudyScreen4State extends State<DailyStudyScreen4> {
  WordItem? selectedWord;
  String? selectedSentenceSignUrl;

  final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LearningProvider>(
        builder: (context, learningProvider, child) {
          final sentence = learningProvider.currentStudy?.sentence ?? '';
          final words = learningProvider.currentStudy?.usedWords ?? [];
          final sentenceImageUrl =
              learningProvider.currentStudy?.sentenceImageUrl ?? '';
          final sentenceSoundUrl =
              learningProvider.currentStudy?.sentenceSoundUrl ?? '';
          final page = learningProvider.currentStudy?.page ?? 1;

          return Stack(
            children: [
              Container(decoration: BoxDecoration(color: AppColors.mainYellow)),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: CustomPaint(
                    painter: WavePainter(
                        color: AppColors.mainSkyBlue, isTopWave: true),
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
                        child:
                            Image.network(sentenceImageUrl, fit: BoxFit.cover),
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
                                  final signUrl = matched.wordSignUrl ?? '';
                                  final isValidUrl =
                                      Uri.tryParse(signUrl)?.hasAbsolutePath ==
                                              true &&
                                          (signUrl.startsWith('http://') ||
                                              signUrl.startsWith('https://'));

                                  if (isValidUrl) {
                                    setState(() {
                                      selectedWord = matched;
                                      _webViewController
                                          .loadRequest(Uri.parse(signUrl));
                                    });
                                  } else {
                                    setState(() {
                                      selectedWord = matched;
                                    });
                                  }
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
                        _buildButton(
                          icon: 'assets/icons/icon_review.png',
                          onTap: () =>
                              _audioPlayer.play(UrlSource(sentenceSoundUrl)),
                        ),
                        SizedBox(width: 20),
                        _buildButton(
                          icon: 'assets/icons/icon_sign.png',
                          onTap: () {
                            final signUrl = learningProvider
                                    .currentStudy?.sentenceSignUrl ??
                                '';

                            setState(() {
                              selectedSentenceSignUrl = signUrl;

                              final isValidUrl =
                                  Uri.tryParse(signUrl)?.hasAbsolutePath ==
                                          true &&
                                      (signUrl.startsWith('http://') ||
                                          signUrl.startsWith('https://'));

                              if (isValidUrl) {
                                _webViewController
                                    .loadRequest(Uri.parse(signUrl));
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (selectedWord != null) _buildPopup(context),
              if (selectedSentenceSignUrl != null) _buildSentencePopup(context),
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
                    '$page',
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

  Widget _buildButton({required String icon, required VoidCallback onTap}) {
    return Stack(
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
          onTap: onTap,
          child: Image.asset(icon, height: 95),
        ),
      ],
    );
  }

  Widget _buildPopup(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: AppColors.textPink,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
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
                          onTap: () => _audioPlayer.play(
                            UrlSource(selectedWord!.wordSoundUrl ?? ''),
                          ),
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: WebViewWidget(controller: _webViewController),
                        ),
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
                onTap: () => setState(() => selectedWord = null),
                child: Icon(Icons.close, color: AppColors.textBlack, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentencePopup(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.textPink,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  "문장 수어 영상",
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.textBlack,
                    fontFamily: 'BMJUA',
                  ),
                ),
                SizedBox(height: 30),
                if (selectedSentenceSignUrl != null &&
                    selectedSentenceSignUrl!.startsWith('http'))
                  SizedBox(
                    width: 300,
                    height: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: WebViewWidget(controller: _webViewController),
                    ),
                  )
                else
                  Text(
                    "제공된 수어 URL이 없습니다.",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.textBlack,
                      fontFamily: 'BMJUA',
                    ),
                  ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () => setState(() => selectedSentenceSignUrl = null),
                child: Icon(Icons.close, color: AppColors.textBlack, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
