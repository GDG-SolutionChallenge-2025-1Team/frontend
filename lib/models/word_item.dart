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
      word: json['content'] ?? '',
      wordMediaUrl: json['media'] ?? '',
      wordSignUrl: json['sign_url'],
      wordSoundUrl: json['sound_url'],
    );
  }
}
