import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/constants/keys.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/helper/shared_prefs.dart';
import 'package:sakina_app/core/utils/custom_snack_bar.dart';
import 'package:sakina_app/core/widgets/custom_button.dart';
import 'package:sakina_app/features/location_permission/presentation/manager/cubit/location_cubit.dart';
import 'package:sakina_app/l10n/app_localizations.dart';

class CustomLocationButton extends StatelessWidget {
  const CustomLocationButton({
    required this.locale,
    super.key,
  });

  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationStateSuccess) {
          Navigator.pushNamed(context, AppRoutes.homeView);
          showCustomSnackBar(context, 'تم تحديد الموقع بنجاح');
          SharedPref.setBool(AppKeys.locationNav, true);
        } else if (state is LocationStateFailure) {
          showCustomSnackBar(context, state.error, isError: true);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: CustomButton(
            isLoading: state is LocationStateLoading,
            style: AppStyles.textMedium18(context).copyWith(
              color: LightAppColors.whiteColor,
            ),
            title: locale.selectionLocationButtonText,
            onPressed: () {
              context.read<LocationCubit>().startLocationService(
                context: context,
              );
            },
          ),
        );
      },
    );
  }
}
