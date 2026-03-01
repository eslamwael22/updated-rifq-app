import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/widgets/audio_list.dart';

class AudioQuranViewBody extends StatelessWidget {
  const AudioQuranViewBody({
    required this.isDark,

    super.key,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          isShow: false,
          title: 'القرآن الكريم',
          subTitle:
              'استمع للقرآن الكريم بصوت الشيخ ${context.read<ReciterDownloadingCubit>().selectedReciterModel?.name}',
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: AudioList(
                  isDark: isDark,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * .22,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
