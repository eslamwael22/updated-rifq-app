import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/features/splash/presentation/view/widgets/custom_circle_container.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    required this.child,
    super.key,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: CustomCircleContainer(
              color: LightAppColors.primaryColor,
              width: MediaQuery.sizeOf(context).width * .8,
              height: MediaQuery.sizeOf(context).height * .3,
              opacity: .09,
              borderWidth: 3,
            ),
          ),
          Positioned(
            top: 0,
            right: 30,
            left: 30,
            bottom: 0,
            child: CustomCircleContainer(
              color: LightAppColors.primaryColor,
              width: MediaQuery.sizeOf(context).width * .8,
              height: MediaQuery.sizeOf(context).height * .3,
              opacity: .09,
              borderWidth: 1,
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: CustomCircleContainer(
              width: MediaQuery.sizeOf(context).width * .8,
              height: MediaQuery.sizeOf(context).height * .3,
              opacity: .09,
              borderWidth: 3,
            ),
          ),
          Positioned.fill(left: 24, right: 24, child: child),
        ],
      ),
    );
  }
}
