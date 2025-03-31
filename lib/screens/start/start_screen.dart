import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/login/google_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 색상
          Container(
            decoration: BoxDecoration(
              color: AppColors.mainYellow,
            ),
          ),

          // // 위쪽 파도
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 250),
              painter: WavePainter(
                color: AppColors.mainSkyBlue,
                isTopWave: true,
              ),
            ),
          ),

          // 아래쪽 파도
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 250),
              painter: WavePainter(
                color: AppColors.mainSkyBlue,
                isTopWave: false,
              ),
            ),
          ),

          // 중앙 컨텐츠
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 'GO' 텍스트
                Text(
                  'GO SARI',
                  style: TextStyle(
                    fontFamily: 'Modak',
                    fontSize: 85,
                    color: AppColors.textSkyBlue,
                    shadows: [
                      Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 0,
                          color: Colors.grey[700]!),
                      Shadow(
                          offset: Offset(-2.0, 2.0),
                          blurRadius: 0,
                          color: Colors.grey[700]!),
                      Shadow(
                          offset: Offset(2.0, -2.0),
                          blurRadius: 0,
                          color: Colors.grey[700]!),
                      Shadow(
                          offset: Offset(-2.0, -2.0),
                          blurRadius: 0,
                          color: Colors.grey[700]!),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // 구글 로그인 버튼 추가
                GoogleLoginButton(
                  // 여기서 콜백함수에서 jwt를 처리하면 될거 같은데
                  onLoginSuccess: (User? user) {
                    if (user != null) {
                      print("로그인 성공: ${user.displayName}");
                      Navigator.pushReplacementNamed(context, '/calendar');
                    } else {
                      print('로그인 실패');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
