import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/learning_model.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/word_item.dart';

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
      words: [
        WordItem(
          word: '친구',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fword_1_1.png?alt=media&token=4ee795a0-1529-4c2f-8248-aa57980eb9db',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw1.mp3?alt=media&token=8cd46d36-8a30-4b34-b281-a0be912916f6',
        ),
        WordItem(
          word: '선물',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fword_1_2.png?alt=media&token=6852b5f8-4f06-43db-b1a0-f2bad3e07baf',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw2.mp3?alt=media&token=4910ef72-6ddd-42f7-97d1-04989d4dda34',
        ),
        WordItem(
          word: '행복',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fword_1_3.png?alt=media&token=3fa916d1-22d4-40b2-a8fd-3d5ee4825381',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw3.mp3?alt=media&token=9d66b64c-f890-4240-a2b3-3906ff57e477',
        ),
      ],
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
    return currentStudy?.emotionMediaUrl ?? '기본 감정 이미지';
  }

  int _wordIndex = 0;
  int get wordIndex => _wordIndex;

  WordItem get currentWordItem {
    return currentStudy?.words[_wordIndex] ??
        WordItem(word: '기본', wordMediaUrl: '');
  }

  String get sentence {
    return currentStudy?.sentence ?? '기본 문장';
  }

  String get wordSignUrl {
    return currentWordItem.wordSignUrl ??
        'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
  }

  bool get isLastWord {
    return _wordIndex >= (currentStudy?.words.length ?? 1) - 1;
  }

  void goToPreviousPage() {
    if (_wordIndex > 0) {
      _wordIndex--;
    } else if (_currentPage > 1) {
      _currentPage--;
    }
    notifyListeners();
  }

  void goToNextPage(VoidCallback onNavigation) {
    final int wordPageCount = currentStudy?.words.length ?? 0;
    if (_currentPage < 8) {
      _currentPage++;

      if (_currentPage <= wordPageCount) {
        _wordIndex++;
      }
    } else {
      currentDay++;
      _currentPage = 1;
      _wordIndex = 0;
      updateLearningData();
    }
    notifyListeners();
    onNavigation();
  }

  void updateLearningData() {
    if (currentDay <= learningData.length) {
      currentStudy = learningData[currentDay - 1];
    } else {
      currentStudy = null;
    }
    notifyListeners();
  }

  String get pageText => '$_currentPage';
}
