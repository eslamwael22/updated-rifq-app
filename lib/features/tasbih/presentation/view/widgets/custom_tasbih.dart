import 'package:flutter/material.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/custom_active_tasbih_item.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/custom_un_active_tasbih_item.dart';

class CustomTasbih extends StatelessWidget {
  const CustomTasbih({
    required this.tasbih,
    required this.index,
    required this.currentIndex,
    super.key,
  });
  final ValueNotifier<int> currentIndex;
  final int index;
  final String tasbih;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder: (context, value, child) {
        final isSelected = value == index;
        return AnimatedCrossFade(
          layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
            return Stack(
              children: [
                Positioned.fill(key: topChildKey, child: bottomChild),
                Positioned.fill(key: bottomChildKey, child: topChild),
              ],
            );
          },
          firstChild: CustomUnActiveTasbihItem(
            tasbihName: tasbih,
          ),
          secondChild: CustomActiveTasbihItem(
            tasbihName: tasbih,
          ),
          crossFadeState: isSelected
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        );
      },
    );
  }
}
