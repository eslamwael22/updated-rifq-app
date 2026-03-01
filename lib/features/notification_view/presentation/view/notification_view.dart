import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/service/get_it_setup.dart';
import 'package:sakina_app/features/notification_view/presentation/manager/notification_cubit.dart';
import 'package:sakina_app/features/notification_view/presentation/view/widget/notification_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => getIt.get<NotificationCubit>()..loadSettings(),
      child: Scaffold(
        body: NotificationViewBody(
          isDark: isDark,
        ),
      ),
    );
  }
}
