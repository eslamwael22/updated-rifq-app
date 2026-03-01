import 'package:flutter/material.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/azkar_view_body.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: AzkarViewBody(),
      ),
    );
  }
}
