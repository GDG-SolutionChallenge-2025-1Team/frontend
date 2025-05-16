import 'word_item.dart';

class LearningModel {
  final int day;
  final int page;

  final String? emotion;
  final String? mediaUrl;

  // 단어 페이지용
  final String? word;
  final String? wordImageUrl;
  final String? wordSignUrl;
  final String? wordSoundUrl;

  // 문장 페이지용
  final String? sentence;
  final String? sentenceImageUrl;
  final String? sentenceSignUrl;
  final String? sentenceSoundUrl;
  final List<WordItem> usedWords;

  LearningModel({
    required this.day,
    required this.page,
    this.emotion,
    this.mediaUrl,
    this.word,
    this.wordImageUrl,
    this.wordSignUrl,
    this.wordSoundUrl,
    this.sentence,
    this.sentenceImageUrl,
    this.sentenceSignUrl,
    this.sentenceSoundUrl,
    required this.usedWords,
  });

  factory LearningModel.fromJson(Map<String, dynamic> json) {
    final usedWordsJson = json['used_word'] as List<dynamic>?;

    return LearningModel(
      day: json['day'] ?? 1,
      page: json['page'] ?? 1,
      emotion: json['main_emotion'],
      mediaUrl: json['media_url'],
      word: json['content'],
      wordImageUrl: json['media_url'],
      wordSignUrl: json['sign_url'],
      wordSoundUrl: json['sound_url'],
      sentence: usedWordsJson != null ? json['content'] : null,
      sentenceImageUrl: usedWordsJson != null ? json['media_url'] : null,
      sentenceSignUrl: usedWordsJson != null ? json['sign_url'] : null,
      sentenceSoundUrl: usedWordsJson != null ? json['sound_url'] : null,
      usedWords: usedWordsJson != null
          ? usedWordsJson
              .map((e) => WordItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}
