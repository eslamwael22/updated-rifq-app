import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/service/get_it_setup.dart';
import 'package:sakina_app/features/hadith/presentation/manager/cubit/hadith_cubit.dart';
import 'package:sakina_app/features/hadith/presentation/view/widgets/hadith_view_body.dart';

class HadithView extends StatelessWidget {
  const HadithView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => getIt.get<HadithCubit>()..loadHadith(),
      child: Scaffold(
        body: HadithViewBody(
          isDark: isDark,
        ),
      ),
    );
  }
}
