import 'package:flutter/material.dart';

class DailyStudyScreen extends StatelessWidget {
  const DailyStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("오늘의 학습")),
      body: Center(child: Text("여기에 오늘의 학습 내용을 추가하세요!")),
    );
  }
}
