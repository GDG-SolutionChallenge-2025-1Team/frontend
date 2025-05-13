import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/learning_model.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/models/word_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LearningProvider with ChangeNotifier {
  int currentDay = 1;
  int _currentPage = 0;
  int get currentPage => _currentPage;

  LearningModel? currentStudy;

  Future<void> changePage({
    required bool forward,
    required VoidCallback onNavigation,
  }) async {
    if (forward) {
      await fetchForwardPage(_currentPage);
    } else {
      await fetchBackwardPage();
    }

    notifyListeners();
    onNavigation();
  }

  Future<void> fetchForwardPage(int page) async {
    final url = Uri.parse(
        'https://soultionchallenge1team-server-231949036311.asia-northeast3.run.app/learning/forward/$page');
    await _fetchFromAPI(url);
  }

  Future<void> fetchBackwardPage() async {
    final url = Uri.parse(
        'https://soultionchallenge1team-server-231949036311.asia-northeast3.run.app/learning/backward');
    await _fetchFromAPI(url);
  }

  String? _jwt;
  void setJwt(String token) {
    _jwt = token;
  }

  Future<void> _fetchFromAPI(Uri url) async {
    if (_jwt == null) return;

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $jwt',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
            jsonDecode(utf8.decode(response.bodyBytes));
        currentDay = jsonData['day'] ?? currentDay;
        _currentPage = jsonData['page'] ?? _currentPage;
        currentStudy = LearningModel.fromJson(jsonData);
      }
    } catch (e) {
      // 예외처리
    }
  }

  String get mainEmotion => currentStudy?.emotion ?? '기본 감정';
  String get emotionMediaUrl => currentStudy?.mediaUrl ?? '';

  int _wordIndex = 0;
  int get wordIndex => _wordIndex;

  WordItem get currentWordItem {
    final list = currentStudy?.usedWords;
    if (list == null || list.isEmpty) {
      return WordItem(word: '기본', wordMediaUrl: '');
    }
    return list[_wordIndex];
  }

  String get sentence => currentStudy?.sentence ?? '기본 문장';

  String get wordSignUrl => currentWordItem.wordSignUrl ?? '';

  bool get isLastWord =>
      _wordIndex >= (currentStudy?.usedWords.length ?? 1) - 1;

  bool goToNextWord() {
    if (_wordIndex < (currentStudy?.usedWords.length ?? 1) - 1) {
      _wordIndex++;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool goToPreviousWord() {
    if (_wordIndex > 0) {
      _wordIndex--;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> updateLearningData({bool resetPage = false}) async {
    if (resetPage) {
      _currentPage = 0;
      _wordIndex = 0;
    }
    await fetchForwardPage(_currentPage);
    notifyListeners();
  }

  String get pageText => '$_currentPage';

  void resetCurrentPage() {
    _currentPage = 0;
    _wordIndex = 0;
    notifyListeners();
  }
}
