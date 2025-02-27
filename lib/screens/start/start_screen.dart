import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/screens/start/login.dart'; // 로그인 화면 임포트

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경을 노란색으로 설정
          Container(
            decoration: BoxDecoration(
              color: AppColors.mainYellow, // 메인 배경 색상을 노란색으로 설정
            ),
          ),

          // 위쪽 파도
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 250), // 파도의 전체 높이 조절
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
              size: Size(MediaQuery.of(context).size.width, 250), // 파도의 전체 높이 조절
              painter: WavePainter(
                color: AppColors.mainSkyBlue,
                isTopWave: false,
              ),
            ),
          ),

          // 중앙 텍스트 (GO SARI)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GO',
                  style: TextStyle(
                    fontFamily: 'Modak',
                    fontSize: 85,
                    color: AppColors.textSkyBlue,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 0,
                        color: Colors.grey[700]!,
                      ),
                      Shadow(
                        offset: Offset(-2.0, 2.0),
                        blurRadius: 0,
                        color: Colors.grey[700]!,
                      ),
                      Shadow(
                        offset: Offset(2.0, -2.0),
                        blurRadius: 0,
                        color: Colors.grey[700]!,
                      ),
                      Shadow(
                        offset: Offset(-2.0, -2.0),
                        blurRadius: 0,
                        color: Colors.grey[700]!,
                      ),
                    ],
                  ),
                ),
                // 'SARI' 텍스트
                Text(
                  'SARI',
                  style: TextStyle(
                    fontFamily: 'Modak',
                    fontSize: 85,
                    color: AppColors.textSkyBlue,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 0,
                        color: Colors.grey[700]!,
                      ),
                      Shadow(
                        offset: Offset(-2.0, 2.0),
                        blurRadius: 0,
                        color: Colors.grey[700]!,
                      ),
                      Shadow(
                        offset: Offset(2.0, -2.0),
                        blurRadius: 0,
                        color: Colors.grey[700]!,
                      ),
                      Shadow(
                        offset: Offset(-2.0, -2.0),
                        blurRadius: 0,
                        color: Colors.grey[700]!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 하단에 "시작하기" 버튼 추가
          Positioned(
            bottom: 40, // 버튼이 화면 하단에서 조금 띄워짐
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 시 login 화면으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainSkyBlue, // 버튼 색상
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                child: Text("시작하기"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
