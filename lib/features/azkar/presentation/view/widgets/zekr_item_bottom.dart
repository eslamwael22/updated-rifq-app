import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class ZekrItemBottom extends StatelessWidget {
  const ZekrItemBottom({required this.type1, required this.type2, super.key});
  final String type1, type2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * .1209302325581395,
        ),
        Expanded(
          child: Wrap(
            runSpacing: 8.h,
            spacing: 8.w,
            children: [
              CustomTypeContainer(
                title: type1,
              ),
              CustomTypeContainer(
                title: type2,
                borderColor: Theme.of(
                  context,
                ).colorScheme.primary.withOpacity(0.12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTypeContainer extends StatelessWidget {
  const CustomTypeContainer({
    required this.title,
    this.borderColor,
    super.key,
  });
  final String title;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color:
              borderColor ??
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: AppStyles.textMedium16(context).copyWith(),
        ),
      ),
    );
  }
}
