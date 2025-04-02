import 'word_item.dart';

class LearningModel {
  final String mainEmotion;
  final String? emotionMediaUrl;
  final List<WordItem> words;
  final String sentence;
  final String? sentenceImageUrl;
  final String? sentenceSoundUrl;

  LearningModel({
    required this.mainEmotion,
    this.emotionMediaUrl,
    required this.words,
    required this.sentence,
    this.sentenceImageUrl,
    this.sentenceSoundUrl,
  });

  factory LearningModel.fromJson(Map<String, String> json) {
    final wordsJson = json['words'] as List<dynamic>? ?? [];

    final words = wordsJson.map((wordJson) {
      return WordItem.fromJson(wordJson as Map<String, dynamic>);
    }).toList();

    return LearningModel(
      mainEmotion: json['mainEmotion']!,
      emotionMediaUrl: json['emotionMediaUrl'],
      words: words,
      sentence: json['sentence']!,
      sentenceImageUrl: json['sentenceImageUrl'],
      sentenceSoundUrl: json['sentenceSoundUrl'],
    );
  }
}
