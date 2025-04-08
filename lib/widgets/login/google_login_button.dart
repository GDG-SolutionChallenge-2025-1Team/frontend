import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/services/auth_service.dart';

class GoogleLoginButton extends StatelessWidget {
  final Function(User?) onLoginSuccess;

  const GoogleLoginButton({super.key, required this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        AuthService authService = AuthService();
        User? user = await authService.signInWithGoogle();
        if (user != null) onLoginSuccess(user);
      },
      child: Container(
        width: 200,
        child: Image.asset(
          'assets/images/google_login_btn.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
