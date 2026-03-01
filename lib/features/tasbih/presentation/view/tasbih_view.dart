import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/service/get_it_setup.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_cubit.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/tasbih_view_body.dart';

class TasbihView extends StatelessWidget {
  const TasbihView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<TasbihCubit>(),
      child: Scaffold(
        body: TasbihViewBody(),
      ),
    );
  }
}
