class WordItem {
  final String word;
  final String wordMediaUrl;
  final String? wordSignUrl;
  final String? wordSoundUrl;

  WordItem({
    required this.word,
    required this.wordMediaUrl,
    this.wordSignUrl,
    this.wordSoundUrl,
  });

  factory WordItem.fromJson(Map<String, dynamic> json) {
    return WordItem(
      word: json['word'] ?? '',
      wordMediaUrl: json['wordMediaUrl'] ?? '',
      wordSignUrl: json['wordSignUrl'],
      wordSoundUrl: json['wordSoundUrl'],
    );
  }
}
