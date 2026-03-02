import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/constants/app_keys.dart';
import 'package:sakina_app/core/helper/shared_prefs.dart';
import 'package:sakina_app/features/splash/presentation/view/widgets/custom_circle_container.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _executeNavigation();
  }

  void _executeNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final locationNav = SharedPref.getBool(AppKeys.locationNav);
      final locationSkip = SharedPref.getBool(AppKeys.locationSkip);
      final onBoardingNav = SharedPref.getBool(AppKeys.onBoardingNav);
      final onBoardingSkip = SharedPref.getBool(AppKeys.onBoardingSkip);

      if (onBoardingNav || onBoardingSkip) {
        if (locationNav || locationSkip) {
          Navigator.pushReplacementNamed(context, AppRoutes.homeView);
        } else {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.locationPermissionView,
          );
        }
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.onBoardingView);
      }
    });
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation = Tween(begin: .85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _slideAnimation =
        Tween(
          begin: const Offset(0, .4),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0F8A67),
                Color(0xFF062F24),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        /// Decorative Circles (أهدى شوية)
        const Positioned(
          top: 100,
          left: 30,
          child: CustomCircleContainer(opacity: .05),
        ),
        const Positioned(
          bottom: 150,
          right: 25,
          child: CustomCircleContainer(opacity: .04),
        ),

        /// Content
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Logo Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    'assets/icons/updated logo.png',
                    width: 250.w,
                    height: 250.h,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// App Name Animation
              SlideTransition(
                position: _slideAnimation,
                child: const Text(
                  'رِفْق',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              SlideTransition(
                position: _slideAnimation,
                child: Text(
                  'Rifq',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white70,
                    letterSpacing: 2,
                  ),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ],
    );
  }
}
