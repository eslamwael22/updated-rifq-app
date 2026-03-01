import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/features/prayer_times/presentation/widgets/custom_prayer_switch.dart';
import 'package:sakina_app/core/notification/adhan_notification.dart';

class NormalPrayer extends StatelessWidget {
  final String prayerName;
  final String time;
  final IconData icon;
  final bool isActive;
  final String? remainingTime;
  final PrayerType prayerType;
  final bool isNotificationEnabled;
  final VoidCallback? onNotificationToggle;

  const NormalPrayer({
    required this.icon,
    required this.isActive,
    required this.prayerName,
    required this.time,
    required this.prayerType,
    this.isNotificationEnabled = true,
    this.onNotificationToggle,
    super.key,
    this.remainingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.04),
            blurRadius: 11.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.h,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: Text(
              prayerName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(width: 8.w),
          Expanded(
            flex: 2,
            child: Text(
              time,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
          ),

          const Spacer(),

          Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
            size: 16.h,
          ),

          SizedBox(width: 6.w),

          CustomPrayerSwitch(
            isEnabled: isNotificationEnabled,
            onTap: onNotificationToggle,
          ),

          SizedBox(width: 6.w),

          Text(
            isNotificationEnabled ? 'مفعّل' : 'معطل',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isNotificationEnabled
                  ? Theme.of(context).iconTheme.color
                  : Colors.grey,
              fontSize: 11.sp,
              fontFamily: 'Cairo',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
