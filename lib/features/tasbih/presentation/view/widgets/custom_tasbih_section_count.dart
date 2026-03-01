import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class CustomTasbihSectionCount extends StatelessWidget {
  const CustomTasbihSectionCount({
    required this.subTitle,
    required this.title,
    super.key,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, 0.00),
              end: Alignment(1.00, 1.00),
              colors: const [Color(0x190C7E5E), Color(0x19D3AF37)],
            ),
            shape: CircleBorder(),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyles.textRegular24(
                context,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: AppStyles.textRegular12(
            context,
          ),
        ),
      ],
    );
  }
}
