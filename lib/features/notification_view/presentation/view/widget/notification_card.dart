import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/notification_view/presentation/view/widget/custom_notiification_switch.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final bool isDark;
  final bool isEnabled;
  final void Function()? onTap;

  const NotificationCard({
    required this.isEnabled,
    required this.title,
    required this.isDark,

    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark ? DarkAppColors.container : LightAppColors.whiteColor,
        border: Border.all(
          color: isDark
              ? DarkAppColors.primaryLight
              : LightAppColors.primaryColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: AppStyles.textRegular18(context).copyWith(
                color: isDark ? Colors.white : DarkAppColors.avatarBackground,
              ),
            ),
          ),
          CustomNoteSwitch(
            onTap: onTap,
            isEnabled: isEnabled,
          ),
        ],
      ),
    );
  }
}
