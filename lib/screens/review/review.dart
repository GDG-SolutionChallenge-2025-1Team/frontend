import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> topics = ["행복", "슬픔", "학교", "친구", "화남", "억울함"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "발음 복습하기",
          style: TextStyle(fontFamily: 'BMJUA'),
        ),
        backgroundColor: AppColors.mainSkyBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  topics[index],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PronunciationReviewScreen(topic: topics[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class PronunciationReviewScreen extends StatelessWidget {
  final String topic;
  const PronunciationReviewScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$topic 발음 복습")),
      body: Center(
        child: Text(
          "$topic 발음을 복습하는 화면입니다.",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'BMJUA'),
        ),
      ),
    );
  }
}
