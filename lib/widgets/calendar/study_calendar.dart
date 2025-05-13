import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/core/theme/app_colors.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/providers/calendar_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class StudyCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<CalendarProvider>(context);

    return TableCalendar(
      firstDay: DateTime.utc(2025, 1, 1),
      lastDay: DateTime.utc(2025, 12, 31),
      focusedDay: dateProvider.focusedDay,
      selectedDayPredicate: (day) => isSameDay(dateProvider.selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        dateProvider.updateDate(selectedDay, focusedDay);
      },
      onPageChanged: (focusedDay) {
        final selectedDay = dateProvider.selectedDay;

        if (selectedDay != null &&
            selectedDay.year == focusedDay.year &&
            selectedDay.month == focusedDay.month) {
          // 선택된 날짜가 이번 달이라면, 그 날짜로 포커스를 이동
          dateProvider.updateDate(selectedDay, selectedDay);
        } else {
          // 아니면 이번 달의 1일로 선택/포커스를 맞춤
          final firstDayOfMonth =
              DateTime(focusedDay.year, focusedDay.month, 1);
          dateProvider.updateDate(firstDayOfMonth, focusedDay);
        }
      },

      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      pageAnimationEnabled: false, // 애니메이션 충돌 방지
      headerVisible: false,

      // 🔹 달력 스타일: 각 행 높이 일정하게 설정
      calendarStyle: CalendarStyle(
        tablePadding: EdgeInsets.symmetric(vertical: 8),
        defaultTextStyle: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700),
        weekendTextStyle: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700),
        todayTextStyle: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700),
        selectedTextStyle: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700),
        todayDecoration: BoxDecoration(
          color: AppColors.mainSkyBlue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.textPink,
          shape: BoxShape.circle,
        ),
        defaultDecoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        weekendDecoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}
