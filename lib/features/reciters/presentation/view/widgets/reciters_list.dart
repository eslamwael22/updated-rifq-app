import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/quran_audio_view.dart';
import 'package:sakina_app/features/reciters/data/models/reciters_model.dart';
import 'package:sakina_app/features/reciters/presentation/view/widgets/reciters_card.dart';

class RecitersList extends StatelessWidget {
  const RecitersList({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final reciter = RecitersModel.reciters[index];
            return GestureDetector(
              onTap: () async {
                final cubit = context.read<ReciterDownloadingCubit>();
                await cubit.initReciter(reciter);
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AudioQuranView(),
                    ),
                  );
                }
              },
              child: ReciterCard(
                reciter: reciter,
                isDark: isDark,
              ),
            );
          },
          childCount: RecitersModel.reciters.length,
        ),
      ),
    );
  }
}
