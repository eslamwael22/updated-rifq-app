import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class CustomAudioQuranNumber extends StatelessWidget {
  const CustomAudioQuranNumber({
    required this.isDark,
    required this.index,
    super.key,
  });

  final bool isDark;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Color.fromRGBO(13, 126, 94, 1),
                  Color.fromRGBO(0, 200, 140, 1),
                ]
              : [
                  Color.fromRGBO(13, 126, 94, 0.25),
                  Color.fromRGBO(13, 126, 94, 0),
                ],
        ),
        shape: CircleBorder(),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: AppStyles.textRegular16(context).copyWith(
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
