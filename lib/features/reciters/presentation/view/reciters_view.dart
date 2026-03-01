import 'package:flutter/material.dart';
import 'package:sakina_app/features/reciters/presentation/view/widgets/reciters_view_body.dart';

class RecitersView extends StatelessWidget {
  const RecitersView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: RecitersViewBody(
        isDark: isDark,
      ),
    );
  }
}
