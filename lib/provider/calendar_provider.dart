import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  // 날짜 선택 및 포커스 업데이트 후 리스너들에게 알림
  void updateDate(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    notifyListeners();
  }
}
