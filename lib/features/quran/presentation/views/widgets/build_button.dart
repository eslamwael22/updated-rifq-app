import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildButton extends StatefulWidget {
  final String title;
  final String count;
  final bool isSelected;
  final VoidCallback onTap;

  const BuildButton({
    required this.title,
    required this.count,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  State<BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25.r),
          border: widget.isSelected
              ? null
              : Border.all(
                  color: Theme.of(context).dividerColor,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: widget.isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
            if (widget.count.isNotEmpty) ...[
              SizedBox(width: 8.w),
              Text(
                widget.count,
                style: TextStyle(
                  color: widget.isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 16.sp,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
