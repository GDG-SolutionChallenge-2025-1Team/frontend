import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/learning_model.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/word_item.dart';

class LearningProvider with ChangeNotifier {
  int currentDay = 1;
  int _currentPage = 1;
  int get currentPage => _currentPage;

  LearningModel? currentStudy;

  final List<LearningModel> learningData = [
    // 1일차
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
    // 2일차
    LearningModel(
      mainEmotion: '감사',
      emotionMediaUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fmain2.png?alt=media&token=57bbee41-6414-4e0b-a944-b27267d927ab',
      words: [
        WordItem(
          word: '선생님',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw2_1.png?alt=media&token=d075a400-aa89-49d8-b35e-15ff5041ec49',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw2_1.wav?alt=media&token=a1a98c99-40a3-4cc8-9e72-f7c6d17d5ea9',
        ),
        WordItem(
          word: '도움',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw2_2.png?alt=media&token=d3fdd63f-9612-4b5e-b8e3-95047553f38e',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw2_2.mp3?alt=media&token=5f28674f-afcf-4222-908b-9a38c3877581',
        ),
        WordItem(
          word: '감사해요',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw2_3.jpg?alt=media&token=aa8e34e2-c601-41cc-8fc1-fb9cf7a43832',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw2_3.mp3?alt=media&token=0e5f74c1-147f-447d-8f6f-b081249ba037',
        ),
      ],
      sentence: '선생님 도움을 주셔서 감사합니다.',
      sentenceImageUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_images%2Fs2.jpg?alt=media&token=0c52eb28-5773-4aee-8d19-714f162c0bb3',
      sentenceSoundUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_sounds%2Fs2.wav?alt=media&token=647bd495-2192-4d34-8a12-0701038be962',
    ),
    // 3일차
    LearningModel(
      mainEmotion: '자신감',
      emotionMediaUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fmain3.png?alt=media&token=20b434b6-c657-433f-8ea1-483bf17f5c24',
      words: [
        WordItem(
          word: '칭찬',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw3_1.jpg?alt=media&token=d332f836-5dc9-46a4-bd38-26d05e0859d2',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw3_1.mp3?alt=media&token=7a8538d5-346f-4670-acb4-e1e81b630fa5',
        ),
        WordItem(
          word: '상장',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw3_2.jpg?alt=media&token=7b70329b-5b00-4bba-9bd0-1cd9befee363',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw3_2.mp3?alt=media&token=ca401985-795c-4934-a7f6-f6723bd64913',
        ),
        WordItem(
          word: '뿌듯해요',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw3_3.jpg?alt=media&token=2cafb544-50b1-4bad-adac-2dc64fe70e10',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw3_3.mp3?alt=media&token=3cbea6e6-7794-4729-ae2a-86579eb413d2',
        ),
      ],
      sentence: '칭찬과 상장을 받아 뿌듯해요',
      sentenceImageUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_images%2Fs3.jpeg?alt=media&token=9580e920-a6f9-4d5d-b3d9-b0616bf49b35',
      sentenceSoundUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_sounds%2Fs3.mp3?alt=media&token=3138e09f-f2ae-4069-bd1d-e954f887cb5d',
    ),
    // 4일차
    LearningModel(
      mainEmotion: '슬픔',
      emotionMediaUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fmain4.gif?alt=media&token=7c8e03c7-b8bc-47ff-9898-86e910f6b2a0',
      words: [
        WordItem(
          word: '소중해요',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw4_1.jpg?alt=media&token=6037dfb0-af92-4a61-ab07-22ba92cd73e7',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw4_1.mp3?alt=media&token=2ec093e1-5332-44ce-b8a8-fb6411a52312',
        ),
        WordItem(
          word: '이별',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw4_2.png?alt=media&token=2c5f7c79-19e9-4599-b11e-1e0e3cc18d46',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw4_2.mp3?alt=media&token=8fcb75e4-45c0-44b8-bca6-a709db4a8994',
        ),
        WordItem(
          word: '슬퍼요',
          wordMediaUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_images%2Fw4_3.jpg?alt=media&token=2bd03e32-f103-40f0-8c27-d5abc165ac2e',
          wordSignUrl:
              'https://youtube.com/shorts/zfg55AimANg?si=dFI_xtKc60G2XnNf',
          wordSoundUrl:
              'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/word_sounds%2Fw4_3.mp3?alt=media&token=acf486b4-1ae2-47cf-b37f-aa36ae740e5f',
        ),
      ],
      sentence: '소중한 친구와 이별을 하게 되어 슬퍼요',
      sentenceImageUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_images%2Fs4.jpg?alt=media&token=2dcd14b5-13f0-47f4-97ad-c85ea777fc47',
      sentenceSoundUrl:
          'https://firebasestorage.googleapis.com/v0/b/login-admin-9eaaf.firebasestorage.app/o/sentence_sounds%2Fs4.mp3?alt=media&token=88641bd3-7a10-491d-bb8d-a9a5d88f6318',
    ),
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

  bool goToNextWord() {
    if (_wordIndex < (currentStudy?.words.length ?? 1) - 1) {
      _wordIndex++;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool goToPreviousWord() {
    if (_wordIndex > 0) {
      _wordIndex--;
      _currentPage--;
      notifyListeners();
      return true;
    }
    return false;
  }

  void goToPreviousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      _wordIndex = 0;
      notifyListeners();
    }
  }

  void goToNextPage(VoidCallback onNavigation) {
    if (_currentPage < 8) {
      _currentPage++;
    } else {
      currentDay++;
      updateLearningData(resetPage: true);
    }
    notifyListeners();
    onNavigation();
  }

  void updateLearningData({bool resetPage = false}) {
    if (currentDay <= learningData.length) {
      currentStudy = learningData[currentDay - 1];
    } else {
      currentStudy = null;
    }
    if (resetPage) {
      _currentPage = 1;
      _wordIndex = 0;
    }
    notifyListeners();
  }

  String get pageText => '$_currentPage';
}
