import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/service/get_it_setup.dart';
import 'package:sakina_app/features/duas/presentation/manager/cubit/duas_cubit.dart';
import 'package:sakina_app/features/duas/presentation/views/widgets/prayers_view_body.dart';

class DuasView extends StatelessWidget {
  const DuasView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => getIt.get<DuasCubit>()..getPrayers(),
      child: Scaffold(
        body: PrayersViewBody(
          isDark: isDark,
        ),
      ),
    );
  }
}
