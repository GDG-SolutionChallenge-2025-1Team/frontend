import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/constants/app_assets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ReviewScreen extends StatefulWidget {
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  bool isPlaying = false;
  bool isListening = false;
  String recognizedText = '';

  final String text = '친구에게 선물을 받아 행복해요';
  final String audioUrl =
      'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_sounds%2Fs1.wav?alt=media&token=3158ecf5-b2f5-4ba5-8fc3-1e27d693d8ea';

  void _showVideoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        YoutubePlayerController _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(
            'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          )!,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '수어',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  label: const Text('닫기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _handleAudioTap() async {
    if (isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    } else {
      try {
        await _audioPlayer.play(UrlSource(audioUrl));
        setState(() {
          isPlaying = true;
        });
      } catch (e) {
        print('오디오 재생 오류: $e');
      }
    }
  }

  Future<void> _toggleSpeechToText() async {
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) return;

    if (!_speechToText.isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) => print('STT 상태: $status'),
        onError: (error) => print('STT 오류: $error'),
      );

      if (available) {
        setState(() => isListening = true);
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              recognizedText = result.recognizedWords;
            });
          },
          localeId: 'ko_KR', // ✅ 꼭 추가해야 한국어 인식 가능
          pauseFor: Duration(seconds: 3),
        );
      } else {
        print('STT 사용 불가');
      }
    } else {
      await _speechToText.stop();
      setState(() => isListening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.mainYellow,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: screenHeight / 1.5,
              child: CustomPaint(
                painter: WavePainter(
                  color: AppColors.mainSkyBlue,
                  isTopWave: true,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.brown, size: 28),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/calendar');
              },
            ),
          ),
          Positioned(
            top: 60,
            child: Text(
              'DAY 1',
              style: const TextStyle(
                fontFamily: 'Modak',
                fontSize: 80,
                color: AppColors.textPink,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: _toggleSpeechToText,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isListening ? '듣고 있어요...' : '곰돌이를 눌러 말해보세요!',
                    style: TextStyle(fontSize: 20, color: Colors.brown[600]),
                  ),
                  const SizedBox(height: 12),
                  Image.asset(
                    AppAssets.imageBear,
                    width: 280,
                    height: 280,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.1,
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown[700]),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _handleAudioTap,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.brown.withOpacity(0.2),
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 40,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: _toggleSpeechToText,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isListening
                              ? Colors.red.withOpacity(0.2)
                              : Colors.green.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.mic,
                          size: 36,
                          color: isListening ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: _showVideoDialog,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        child: const Icon(
                          Icons.play_circle_fill,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  recognizedText,
                  style: TextStyle(fontSize: 18, color: Colors.brown[800]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
