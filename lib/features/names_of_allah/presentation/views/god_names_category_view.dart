import 'package:flutter/material.dart';
import 'package:sakina_app/features/names_of_allah/presentation/views/widgets/god_names_category_body.dart';

class GodNamesCategoryView extends StatelessWidget {
  const GodNamesCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GodNamesCategoryBody(),
      ),
    );
  }
}
