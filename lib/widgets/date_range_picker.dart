import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class DateRangePicker1 extends StatefulWidget {
  final Function(DateTimeRange) onDateRangeSelected;
  final DateTimeRange? initialDateRange;

  const DateRangePicker1({
    super.key,
    required this.onDateRangeSelected,
    this.initialDateRange,
  });

  @override
  State<DateRangePicker1> createState() => _DateRangePicker1State();
}

class _DateRangePicker1State extends State<DateRangePicker1> {
  late DateTime _focusedMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedPreset = 'Custom';

  final List<String> _presets = ['Last 7 days', 'Last 14 days', 'Last 30 days'];

  @override
  void initState() {
    super.initState();
    _focusedMonth = DateTime.now();
    if (widget.initialDateRange != null) {
      _startDate = widget.initialDateRange!.start;
      _endDate = widget.initialDateRange!.end;
    }
  }

  void _selectPreset(String preset) {
    setState(() {
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
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
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
    });
  }

  bool _isInRange(DateTime date) {
    if (_startDate == null) return false;
    if (_endDate == null) return date.isAtSameMomentAs(_startDate!);
    return (date.isAfter(_startDate!) || date.isAtSameMomentAs(_startDate!)) &&
        (date.isBefore(_endDate!) || date.isAtSameMomentAs(_endDate!));
  }

  bool _isSelected(DateTime date) {
    return (_startDate != null && _isSameDay(date, _startDate!)) ||
        (_endDate != null && _isSameDay(date, _endDate!));
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.elevation17,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Preset tabs
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPresetTab('Date range'),
                  ..._presets.map((preset) => _buildPresetTab(preset)),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Month navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _previousMonth,
                      color: AppColors.textPrimary,
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(_focusedMonth),
                      style: AppTheme.h5Strong.copyWith(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _nextMonth,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Weekday headers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                      .map(
                        (day) => SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              day,
                              style: AppTheme.pLight.copyWith(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),

                // Calendar grid
                _buildCalendarGrid(),

                const SizedBox(height: 20),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: AppTheme.h5Strong.copyWith(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _startDate != null && _endDate != null
                          ? () {
                              widget.onDateRangeSelected(
                                DateTimeRange(
                                  start: _startDate!,
                                  end: _endDate!,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        disabledBackgroundColor:
                            AppColors.primaryPurple.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Set date',
                        style: AppTheme.buttonText.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetTab(String label) {
    final isSelected = _selectedPreset == label || label == 'Date range';
    return GestureDetector(
      onTap: () => label != 'Date range' ? _selectPreset(label) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected && label != 'Date range'
              ? AppColors.purple100.withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: AppTheme.pStrong.copyWith(
            fontSize: 12,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(
      _focusedMonth.year,
      _focusedMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _focusedMonth.year,
      _focusedMonth.month + 1,
      0,
    );
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    final previousMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    final daysInPreviousMonth = DateTime(
      _focusedMonth.year,
      _focusedMonth.month,
      0,
    ).day;

    List<Widget> dayWidgets = [];

    // Previous month days
    for (int i = firstWeekday - 1; i > 0; i--) {
      final day = daysInPreviousMonth - i + 1;
      dayWidgets.add(
        _buildDayCell(
          DateTime(previousMonth.year, previousMonth.month, day),
          isCurrentMonth: false,
        ),
      );
    }

    // Current month days
    for (int day = 1; day <= daysInMonth; day++) {
      dayWidgets.add(
        _buildDayCell(
          DateTime(_focusedMonth.year, _focusedMonth.month, day),
          isCurrentMonth: true,
        ),
      );
    }

    // Next month days to fill grid
    final remainingCells = 42 - dayWidgets.length;
    for (int day = 1; day <= remainingCells; day++) {
      dayWidgets.add(
        _buildDayCell(
          DateTime(_focusedMonth.year, _focusedMonth.month + 1, day),
          isCurrentMonth: false,
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: dayWidgets,
    );
  }

  Widget _buildDayCell(DateTime date, {required bool isCurrentMonth}) {
    final isInRange = _isInRange(date);
    final isSelected = _isSelected(date);
    final isToday = _isSameDay(date, DateTime.now());

    return GestureDetector(
      onTap: isCurrentMonth ? () => _selectDate(date) : null,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryPurple
              : isInRange
                  ? AppColors.purple100.withOpacity(0.3)
                  : Colors.transparent,
          shape: BoxShape.circle,
          border: isToday && !isSelected
              ? Border.all(color: AppColors.primaryPurple, width: 1)
              : null,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: AppTheme.pLight.copyWith(
              fontSize: 14,
              color: isSelected
                  ? AppColors.white
                  : isCurrentMonth
                      ? AppColors.textPrimary
                      : AppColors.textDisabled,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

// Helper function to show date range picker
Future<DateTimeRange?> showCustomDateRangePicker1({
  required BuildContext context,
  DateTimeRange? initialDateRange,
}) async {
  DateTimeRange? selectedRange;

  await showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: DateRangePicker1(
        initialDateRange: initialDateRange,
        onDateRangeSelected: (range) {
          selectedRange = range;
        },
      ),
    ),
  );

  return selectedRange;
}