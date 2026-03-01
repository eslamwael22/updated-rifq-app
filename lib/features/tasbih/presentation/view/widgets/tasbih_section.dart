import 'package:flutter/material.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/custom_statics_item.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/custom_target_item.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/tasbih_button.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/tasbih_counter.dart';

class TasbihSection extends StatelessWidget {
  const TasbihSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color.fromRGBO(18, 48, 40, 1) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1.5,
          color: isDark
              ? const Color.fromRGBO(39, 69, 61, 1)
              : const Color.fromRGBO(13, 126, 94, 0.15),
        ),
        boxShadow: isDark
            ? const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ]
            : const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
      ),
      child: Column(
        children: [
          const TasbihCounter(),
          const SizedBox(height: 24),
          const TasbihButton(),
          const SizedBox(height: 24),
          CustomTargetItem(isDark: isDark),
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.3,
            child: Divider(thickness: 2),
          ),

          const SizedBox(height: 4),
          const CustomStaticsItem(),
        ],
      ),
    );
  }
}
