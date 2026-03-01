// riquat_type_selector.dart
import 'package:flutter/material.dart';
import 'package:sakina_app/features/riquat_shareia/data/models/selector_model.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/custom_tap.dart';

class RiquatTypeSelector extends StatefulWidget {
  const RiquatTypeSelector({
    required this.isDark,
    required this.onChanged,
    super.key,
  });

  final bool isDark;
  final Function(int) onChanged;

  @override
  State<RiquatTypeSelector> createState() => _RiquatTypeSelectorState();
}

class _RiquatTypeSelectorState extends State<RiquatTypeSelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDark
        ? const Color(0xFF162A25)
        : const Color(0xFFE6F4EF);
    final borderColor = widget.isDark
        ? const Color(0xFF2A4B3F)
        : const Color(0xFFBDE3D3);
    final selectedGradient = widget.isDark
        ? const LinearGradient(
            colors: [Color(0xFF2BC299), Color(0xFF1DA57F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFF0DA77B), Color(0xFF2BD498)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 58,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor,
          border: Border.all(color: borderColor),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final segmentWidth =
                constraints.maxWidth / SelectorModel.selectorList.length;
            return Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: selectedIndex == 0
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: segmentWidth,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: selectedGradient,
                    ),
                  ),
                ),

                Row(
                  children: List.generate(
                    SelectorModel.selectorList.length,
                    (index) {
                      final item = SelectorModel.selectorList[index];
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            widget.onChanged(index);
                          });
                        },
                        child: CustomTap(
                          segmentWidth: segmentWidth,
                          item: item,
                          isSelected: isSelected,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
