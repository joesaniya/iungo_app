import 'package:flutter/material.dart';

class DateRangePickerProvider extends ChangeNotifier {
  late DateTime _focusedMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedPreset = 'Custom';

  final List<String> presets = [
    'Last 7 days',
    'Last 14 days',
    'Last 30 days',
  ];

  DateRangePickerProvider({DateTimeRange? initialDateRange}) {
    _focusedMonth = DateTime.now();
    if (initialDateRange != null) {
      _startDate = initialDateRange.start;
      _endDate = initialDateRange.end;
    }
  }

  // Getters
  DateTime get focusedMonth => _focusedMonth;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String get selectedPreset => _selectedPreset;
  bool get isDateRangeValid => _startDate != null && _endDate != null;

  // Select preset
  void selectPreset(String preset) {
    _selectedPreset = preset;
    final now = DateTime.now();
    _endDate = now;

    switch (preset) {
      case 'Last 7 days':
        _startDate = now.subtract(const Duration(days: 7));
        break;
      case 'Last 14 days':
        _startDate = now.subtract(const Duration(days: 14));
        break;
      case 'Last 30 days':
        _startDate = now.subtract(const Duration(days: 30));
        break;
      default:
        _selectedPreset = 'Custom';
    }
    notifyListeners();
  }

  // Select date
  void selectDate(DateTime date) {
    if (_startDate == null || (_startDate != null && _endDate != null)) {
      _startDate = date;
      _endDate = null;
      _selectedPreset = 'Custom';
    } else if (_endDate == null) {
      if (date.isBefore(_startDate!)) {
        _endDate = _startDate;
        _startDate = date;
      } else {
        _endDate = date;
      }
    }
    notifyListeners();
  }

  // Check if date is in range
  bool isInRange(DateTime date) {
    if (_startDate == null) return false;
    if (_endDate == null) return date.isAtSameMomentAs(_startDate!);
    return (date.isAfter(_startDate!) || date.isAtSameMomentAs(_startDate!)) &&
        (date.isBefore(_endDate!) || date.isAtSameMomentAs(_endDate!));
  }

  // Check if date is selected
  bool isSelected(DateTime date) {
    return (_startDate != null && _isSameDay(date, _startDate!)) ||
        (_endDate != null && _isSameDay(date, _endDate!));
  }

  // Navigate to previous month
  void previousMonth() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    notifyListeners();
  }

  // Navigate to next month
  void nextMonth() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    notifyListeners();
  }

  // Get date range
  DateTimeRange? getDateRange() {
    if (_startDate != null && _endDate != null) {
      return DateTimeRange(start: _startDate!, end: _endDate!);
    }
    return null;
  }

  // Helper method
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}