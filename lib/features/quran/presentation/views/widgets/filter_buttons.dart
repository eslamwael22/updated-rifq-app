// lib/features/quran/presentation/views/widgets/filter_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'build_button.dart';

class FilterButtons extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const FilterButtons({
    required this.selectedType,
    required this.onTypeSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: BuildButton(
            title: 'الكل',
            count: '',
            isSelected: selectedType == 'الكل',
            onTap: () => onTypeSelected('الكل'),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: BuildButton(
            title: 'مكية',
            count: '86',
            isSelected: selectedType == 'مكية',
            onTap: () => onTypeSelected('مكية'),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: BuildButton(
            title: 'مدنية',
            count: '28',
            isSelected: selectedType == 'مدنية',
            onTap: () => onTypeSelected('مدنية'),
          ),
        ),
      ],
    );
  }
}
