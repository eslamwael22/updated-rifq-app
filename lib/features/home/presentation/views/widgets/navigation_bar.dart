import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MainNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // لو -1 نحط 0 بس بدون تحديد حقيقي
    final safeIndex = currentIndex < 0 ? 0 : currentIndex;

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: Theme.of(context).colorScheme.primary,

        indicatorColor: currentIndex < 0
            ? Colors.transparent
            : Theme.of(context).colorScheme.onPrimary.withOpacity(0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: currentIndex < 0
                  ? FontWeight.normal
                  : FontWeight.bold,
              fontFamily: 'cairo',
              fontSize: 12.sp,
            );
          }
          return TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 12.sp,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
            size: 24.h,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: safeIndex,
        onDestinationSelected: onTap,
        height: MediaQuery.sizeOf(context).height * .09,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_rounded),
            label: 'المصحف',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_alarms_rounded),
            label: 'الاذان',
          ),
          NavigationDestination(
            icon: Icon(Icons.headphones),
            label: 'الاستماع للقران',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_stories),
            label: 'الأذكار',
          ),
        ],
      ),
    );
  }
}
