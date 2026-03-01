import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/service/get_it_setup.dart';
import 'package:sakina_app/features/location_permission/presentation/manager/cubit/location_cubit.dart';
import 'package:sakina_app/features/location_permission/presentation/views/widgets/location_permission_view_body.dart';

class LocationPermissionView extends StatelessWidget {
  const LocationPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<LocationCubit>(),
      child: Scaffold(
        body: LocationPermissionViewBody(),
      ),
    );
  }
}
