class LearningModel {
  final String mainEmotion;
  final String emotionMediaUrl;
  final String word;
  final String wordMediaUrl;
  final String? wordSignUrl;
  final String? wordSoundUrl;

  final String sentence;
  final String? sentenceImageUrl;
  final String? sentenceSoundUrl;

  LearningModel({
    required this.mainEmotion,
    required this.emotionMediaUrl,
    required this.word,
    required this.wordMediaUrl,
    this.wordSignUrl,
    this.wordSoundUrl,
    required this.sentence,
    this.sentenceImageUrl,
    this.sentenceSoundUrl,
  });

  factory LearningModel.fromJson(Map<String, String> json) {
    return LearningModel(
      mainEmotion: json['mainEmotion']!,
      emotionMediaUrl: json['emotionMediaUrl']!,
      word: json['word']!,
      wordMediaUrl: json['wordMediaUrl']!,
      wordSignUrl: json['wordSignUrl'],
      wordSoundUrl: json['wordSoundUrl'],
      sentence: json['sentence']!,
      sentenceImageUrl: json['sentenceImageUrl'],
      sentenceSoundUrl: json['sentenceSoundUrl'],
    );
  }
}
