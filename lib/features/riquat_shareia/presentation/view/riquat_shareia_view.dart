import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/service/get_it_setup.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/manager/riquat_quran_cubit/riquat_quran_cubit.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/manager/riquat_sunnah_cubit/riquat_sunnah_cubit.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/riquat_vew_body.dart';

class RiquatView extends StatelessWidget {
  const RiquatView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<RiquatSunnahCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<RiquatQuranCubit>(),
        ),
      ],
      child: Scaffold(
        body: RiquatViewBody(isDark: isDark),
      ),
    );
  }
}
