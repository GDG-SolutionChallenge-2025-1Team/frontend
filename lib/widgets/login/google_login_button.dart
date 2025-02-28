import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/services/auth_service.dart';

class GoogleLoginButton extends StatelessWidget {
  final Function(User?) onLoginSuccess;

  const GoogleLoginButton({super.key, required this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // 배경 흰색
        foregroundColor: Colors.black87, // 글씨 검정
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey[300]!), // 테두리 추가
        ),
        elevation: 2, // 그림자 추가
      ),
      onPressed: () async {
        AuthService authService = AuthService();
        User? user = await authService.signInWithGoogle();
        // user 객체가 존재한다면 onLoginSuccess 콜백함세우 user 객체를 넘겨줌
        if (user != null) onLoginSuccess(user);
      },
      child: const Text(
        "구글로 로그인할래요.",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500, // 가독성을 위해 Medium 적용
        ),
      ),
    );
  }
}
