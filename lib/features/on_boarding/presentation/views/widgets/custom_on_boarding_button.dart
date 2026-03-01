import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/constants/keys.dart';
import 'package:sakina_app/core/helper/shared_prefs.dart';
import 'package:sakina_app/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:sakina_app/features/on_boarding/presentation/views/widgets/custom_arrow.dart';

class CustomOnBoardingButton extends StatelessWidget {
  const CustomOnBoardingButton({
    required ValueNotifier<int> currentIndex,
    required PageController pageController,
    super.key,
  }) : _currentIndex = currentIndex,
       _pageController = pageController;

  final ValueNotifier<int> _currentIndex;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final buttonColor = isDark
        ? const Color(0xFF2BD498)
        : const Color(0xFF0DA77B);

    final skipColor = isDark ? Colors.white : const Color(0xFF0DA77B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleArrow(
          icon: Icons.arrow_back_ios_rounded,
          color: buttonColor,
          onTap: () {
            if (_currentIndex.value > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),

        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.locationPermissionView,
            );
            SharedPref.setBool(AppKeys.onBoardingSkip, true);
          },
          child: Text(
            'تخطي',
            style: TextStyle(
              fontSize: 18,
              color: skipColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        CircleArrow(
          icon: Icons.arrow_forward_ios_rounded,
          color: buttonColor,
          onTap: () {
            if (_currentIndex.value <
                OnBoardingModel.onBoardingList.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.locationPermissionView,
              );
              SharedPref.setBool(AppKeys.onBoardingNav, true);
            }
          },
        ),
      ],
    );
  }
}
