import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("발음 복습하기")),
      body: Center(child: Text("여기에 발음 복습 내용을 추가하세요!")),
    );
  }
}
