import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/calendar_provider.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/routes.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/calendar/study_calendar.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/wave_painter.dart';

import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // CalendarProvider 접근
    final calendarProvider = Provider.of<CalendarProvider>(context);
    final focusedMonth = calendarProvider.focusedDay.month;

    // 월을 문자열로 변환 (예: 3 -> "3월")
    final focusedMonthText = "$focusedMonth월";

    return Scaffold(
      backgroundColor: AppColors.mainYellow,
      body: Stack(
        children: [
          // 배경 파도
          Positioned(
            top: -25,
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

          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                focusedMonthText,
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBrown,
                  fontFamily: 'BMJUA',
                ),
              ),
            ),
          ),

          // 메인 컨텐츠
          Center(
            child: Column(
                mainAxisSize: MainAxisSize.min, // Column이 화면 전체를 차지하지 않도록 설정

                children: [
                  SizedBox(height: 150),
                  SizedBox(
                    height: 400, // 달력 크기를 일정하게 고정
                    child: StudyCalendar(),
                  ),
                  _buildMenuItem("복습하기", AppRoutes.review, context),
                  _buildMenuItem("뒤로가기", AppRoutes.home, context)
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String label, String routeName, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: AppColors.buttonYellow,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'BMJUA',
                  color: AppColors.textBrown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
