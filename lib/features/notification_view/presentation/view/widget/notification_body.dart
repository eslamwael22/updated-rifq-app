import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/notification_view/presentation/manager/notification_cubit.dart';
import 'package:sakina_app/features/notification_view/presentation/manager/notification_state.dart';
import 'package:sakina_app/features/notification_view/presentation/view/widget/notification_card.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({required this.isDark, super.key});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          isShow: false,
          title: 'الاشعارات',
          subTitle: 'قائمة الاشعارات',
        ),
        const SizedBox(height: 20),
        BlocBuilder<NotificationCubit, NotificationState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  NotificationCard(
                    isEnabled: state.salawat,
                    isDark: isDark,
                    title: notificationTitle[0],
                    onTap: () {
                      context.read<NotificationCubit>().toggleSalawat(
                        !state.salawat,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  NotificationCard(
                    isEnabled: state.randomAzkar,
                    isDark: isDark,
                    title: notificationTitle[1],
                    onTap: () {
                      context.read<NotificationCubit>().toggleRandomAzkar(
                        !state.randomAzkar,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  NotificationCard(
                    isEnabled: state.morningEvening,
                    isDark: isDark,
                    title: notificationTitle[2],
                    onTap: () {
                      context.read<NotificationCubit>().toggleMorningEvening(
                        !state.morningEvening,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  NotificationCard(
                    isEnabled: state.dailyWerd,
                    isDark: isDark,
                    title: notificationTitle[3],
                    onTap: () {
                      context.read<NotificationCubit>().toggleDailyWerd(
                        !state.dailyWerd,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

List<String> notificationTitle = [
  'تنبيهات الصلاة على النبي ﷺ',
  'تنبيهات الأذكار العشوائية',
  'تنبيهات أذكار الصباح والمساء',
  'تنبيهات الورد القرآني اليومي',
];
