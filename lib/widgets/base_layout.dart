import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  
  const BaseLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('솔루션 챌린지 1팀'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 설정 버튼 클릭 시 동작
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}