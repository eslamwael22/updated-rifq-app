import 'package:flutter/material.dart';
import 'package:sakina_app/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:sakina_app/features/on_boarding/presentation/views/widgets/custom_dots_indicator.dart';
import 'package:sakina_app/features/on_boarding/presentation/views/widgets/custom_on_boarding_button.dart';
import 'package:sakina_app/features/on_boarding/presentation/views/widgets/custom_on_boarding_page_view_item.dart';
import 'package:sakina_app/features/splash/presentation/view/widgets/custom_circle_container.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDark ? null : Colors.white,
            gradient: isDark
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF162A25),
                      Color(0xFF0F1F1B),
                    ],
                  )
                : null,
          ),
        ),

        if (isDark) ...[
          const Positioned(
            top: -80,
            left: -80,
            child: CustomCircleContainer(opacity: 0.05),
          ),
          const Positioned(
            bottom: -80,
            right: -80,
            child: CustomCircleContainer(opacity: 0.05),
          ),
        ],

        PageView.builder(
          controller: _pageController,
          itemCount: OnBoardingModel.onBoardingList.length,
          onPageChanged: (index) => _currentIndex.value = index,
          itemBuilder: (context, index) {
            final page = OnBoardingModel.onBoardingList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CustomOnBoardingItem(page: page),
            );
          },
        ),

        Positioned(
          bottom: 110,
          left: 0,
          right: 0,
          child: CustomDotsIndicator(currentIndex: _currentIndex),
        ),

        Positioned(
          bottom: 40,
          left: 32,
          right: 32,
          child: CustomOnBoardingButton(
            currentIndex: _currentIndex,
            pageController: _pageController,
          ),
        ),
      ],
    );
  }
}
