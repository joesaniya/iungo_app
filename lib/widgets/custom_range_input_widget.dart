import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iungo_application/widgets/date_range_picker_widget.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';


class CustomDateRangeInput extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final Function(DateTime?, DateTime?) onDateRangeSelected;

  const CustomDateRangeInput({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.onDateRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: AppTheme.inputLabel.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final DateTimeRange? range = await showCustomDateRangePicker(
              context: context,
              initialDateRange: fromDate != null && toDate != null
                  ? DateTimeRange(start: fromDate!, end: toDate!)
                  : null,
            );
            
            if (range != null) {
              onDateRangeSelected(range.start, range.end);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    fromDate != null && toDate != null
                        ? '${DateFormat('dd MMM yyyy').format(fromDate!)} - ${DateFormat('dd MMM yyyy').format(toDate!)}'
                        : 'Select date range',
                    style: AppTheme.h5Strong.copyWith(
                      fontSize: 14,
                      color: fromDate != null && toDate != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}