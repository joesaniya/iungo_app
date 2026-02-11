import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final String hint;
  final bool enableSearch; // New parameter
  final int searchThreshold; // Show search after X items

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint = 'All',
    this.enableSearch = true, // Enable by default
    this.searchThreshold = 5, // Search appears for 5+ items
  });

  @override
  Widget build(BuildContext context) {
    // Decide if search should be enabled based on item count
    final bool shouldShowSearch =
        enableSearch && items.length >= searchThreshold;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.inputLabel.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownSearch<String>(
          items: (filter, infiniteScrollProps) => items,
          selectedItem: value,
          onChanged: onChanged,

          // Popup configuration
          popupProps: PopupProps.menu(
            showSearchBox: shouldShowSearch,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: 'Search $label...',
                hintStyle: AppTheme.h5Light.copyWith(
                  color: AppColors.textSecondary,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            searchDelay: const Duration(milliseconds: 300), // Debounce
            menuProps: MenuProps(
              borderRadius: BorderRadius.circular(8),
              elevation: 4,
            ),
            itemBuilder: (context, item, isDisabled, isSelected) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryPurple.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Text(
                  item,
                  style: AppTheme.h5Strong.copyWith(
                    fontSize: 14,
                    color: isSelected
                        ? AppColors.primaryPurple
                        : AppColors.textPrimary,
                  ),
                ),
              );
            },
            emptyBuilder: (context, searchEntry) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No items found',
                    style: AppTheme.pLight.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            },
          ),

          // Dropdown decorator configuration
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTheme.h5Light.copyWith(
                color: AppColors.textSecondary,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primaryPurple,
                  width: 1.5,
                ),
              ),
            ),
          ),

          // Suffix icon
          suffixProps: DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              iconClosed: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textSecondary,
              ),
              iconOpened: const Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.primaryPurple,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
