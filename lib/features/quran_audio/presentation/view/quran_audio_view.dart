import 'package:flutter/material.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/widgets/audio_quran_view_body.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/widgets/custom_audio_bottom_sheet.dart';

class AudioQuranView extends StatelessWidget {
  const AudioQuranView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: AudioQuranViewBody(
        isDark: isDark,
      ),
      bottomSheet: CustomAudioBottomSheet(isDark: isDark),
    );
  }
}
