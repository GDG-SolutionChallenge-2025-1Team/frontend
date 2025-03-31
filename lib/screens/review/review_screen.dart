import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/constants/app_assets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReviewScreen extends StatefulWidget {
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Record _recorder = Record();

  bool isPlaying = false;
  bool isRecording = false;
  String? recordedFilePath;

  final String text = '친구에게 선물을 받아 행복해요';
  final String audioUrl =
      'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_sounds%2Fs1.wav?alt=media&token=3158ecf5-b2f5-4ba5-8fc3-1e27d693d8ea';

  void _showVideoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        YoutubePlayerController _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(
            ' https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf', // 원하는 유튜브 링크로 교체
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
                  alignment: Alignment.center, // 가로 중앙 정렬
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

    // 오디오 종료 감지 후 상태 업데이트
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _recorder.dispose();
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

  Future<void> _handleRecordToggle() async {
    if (!isRecording) {
      // 디버깅용 로그 추가
      print('녹음 시작 시도...');

      // 마이크 권한 요청
      final status = await Permission.microphone.request();

      if (status.isPermanentlyDenied) {
        // 설정 화면으로 유도
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('마이크 권한 필요'),
            content: Text('녹음을 위해 마이크 권한이 필요합니다. 설정에서 권한을 허용해주세요.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  openAppSettings(); // 앱 설정으로 이동
                  Navigator.of(context).pop();
                },
                child: Text('설정 열기'),
              ),
            ],
          ),
        );
        return;
      }

      // 녹음 설정
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/my_voice.m4a';
      print('녹음 파일 경로: $path');

      try {
        // 권한 확인
        final hasPermission = await _recorder.hasPermission();
        print('record 패키지 권한 확인: $hasPermission');

        if (hasPermission) {
          // 녹음 시작
          print('녹음 시작 중...');
          await _recorder.start(
            path: path,
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            samplingRate: 44100,
          );
          print('녹음 시작됨!');

          setState(() {
            isRecording = true;
            recordedFilePath = path;
          });
        } else {
          print('record 패키지가 권한이 없다고 보고함');
        }
      } catch (e) {
        print('녹음 시작 중 오류 발생: $e');
      }
    } else {
      // 녹음 중지
      print('녹음 중지 시도...');
      try {
        final path = await _recorder.stop();
        print('녹음 중지됨, 저장된 경로: $path');
        setState(() {
          isRecording = false;
          if (path != null) {
            recordedFilePath = path;
          }
        });
      } catch (e) {
        print('녹음 중지 중 오류 발생: $e');
        setState(() {
          isRecording = false;
        });
      }
    }
  }

  Future<void> _playMyVoice() async {
    if (recordedFilePath != null) {
      await _audioPlayer.play(DeviceFileSource(recordedFilePath!));
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
          // 배경 물결
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
                fontFamily: 'Modak', // ✅ 폰트 이름 정확히 일치해야 함!
                fontSize: 80,
                color: AppColors.textPink,
              ),
            ),
          ),

          // 곰돌이 이미지
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: _playMyVoice,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '나를 클릭하면 너의 목소리가 들려!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown[600],
                    ),
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
                    color: Colors.brown[700],
                  ),
                ),
                const SizedBox(height: 30),

                // ▶️ / 🎙️ 버튼 가로 정렬
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 문장 재생 버튼
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

                    // 내 발음 녹음 버튼
                    GestureDetector(
                      onTap: _handleRecordToggle,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isRecording
                              ? Colors.red.withOpacity(0.2)
                              : Colors.brown.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.mic,
                          size: 36,
                          color: isRecording ? Colors.red : Colors.brown,
                        ),
                      ),
                    ),

                    const SizedBox(width: 24),

                    // ▶️ 새 동영상 버튼
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

                const SizedBox(height: 12),

                // 상태 텍스트 아래에 살짝 표시 (선택)
                Text(
                  isRecording ? '녹음 중...' : '내 발음을 녹음해보세요',
                  style: TextStyle(
                    fontSize: 14,
                    color: isRecording ? Colors.red : Colors.brown[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
