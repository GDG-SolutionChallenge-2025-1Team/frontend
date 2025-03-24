import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/learning_model.dart';

class LearningProvider with ChangeNotifier {
  int currentDay = 1;
  int _currentPage = 1;
  int get currentPage => _currentPage;

  LearningModel? currentStudy;

  final List<LearningModel> learningData = [
    // 첫 번째 일차
    LearningModel(
      mainEmotion: '행복',
      emotionMediaUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fmain1.png?alt=media&token=344c267e-0b9f-4805-8a5f-fda65f90844e',
      word: '친구',
      wordMediaUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fword_1_1.png?alt=media&token=4ee795a0-1529-4c2f-8248-aa57980eb9db',
      wordSignUrl: 'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
      wordSoundUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw1.mp3?alt=media&token=8cd46d36-8a30-4b34-b281-a0be912916f6',
      sentence: '친구에게 선물을 받아 행복해요',
      sentenceImageUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_images%2Fs1.jpg?alt=media&token=95010f31-7f79-43b2-b292-9bfdc9c10888',
      sentenceSoundUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_sounds%2Fs1.wav?alt=media&token=3158ecf5-b2f5-4ba5-8fc3-1e27d693d8ea',
    ),
    // 두 번째 일차 등의 데이터
  ];

  LearningProvider() {
    updateLearningData();
  }

  String get mainEmotion {
    return currentStudy?.mainEmotion ?? '기본 감정';
  }

  String get emotionMediaUrl {
    return currentStudy?.mainEmotion ?? '기본 감정 이미지';
  }

  String get word {
    return currentStudy?.word ?? '기본 단어';
  }

  String get sentence {
    return currentStudy?.sentence ?? '기본 문장';
  }

  String get wordSignUrl {
    return currentStudy?.wordSignUrl ??
        'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
  }

  void decreasePage() {
    if (currentPage > 1) {
      _currentPage--;
      notifyListeners();
    }
  }

  void goToNextPage() {
    if (_currentPage < 6) {
      _currentPage++;
    } else if (currentDay == 6) {
      _currentPage = 1;
      currentDay++;
    }

    updateLearningData();
    notifyListeners();
  }

  void updateLearningData() {
    if (currentDay <= learningData.length) {
      currentStudy = learningData[currentDay - 1];
    } else {
      currentStudy = null;
    }
    notifyListeners();
  }
}
