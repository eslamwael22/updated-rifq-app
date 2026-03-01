import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/riquat_shareia/data/enum/riquat_enum.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/manager/riquat_quran_cubit/riquat_quran_cubit.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/manager/riquat_sunnah_cubit/riquat_sunnah_cubit.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/riquat_quran_list.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/riquat_sunnah_list.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/riquat_type_selector.dart';

class RiquatViewBody extends StatefulWidget {
  const RiquatViewBody({required this.isDark, super.key});
  final bool isDark;

  @override
  State<RiquatViewBody> createState() => _RiquatViewBodyState();
}

class _RiquatViewBodyState extends State<RiquatViewBody> {
  RiquatType selectedType = RiquatType.quran;
  @override
  void initState() {
    loadRiquat();
    super.initState();
  }

  void loadRiquat() {
    if (selectedType == RiquatType.quran) {
      BlocProvider.of<RiquatQuranCubit>(context).loadRiquatQuran();
    } else {
      BlocProvider.of<RiquatSunnahCubit>(context).loadRiquatSunnah();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          isShow: false,
          title: 'الرقية الشرعية  ',
          subTitle: 'الرقية الشرعية من القرآن و السيرة',
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      RiquatTypeSelector(
                        isDark: widget.isDark,
                        onChanged: (index) {
                          setState(() {
                            selectedType = RiquatType.values[index];
                          });
                          loadRiquat();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: selectedType == RiquatType.quran
                    ? RiquatQuranList(isDark: widget.isDark)
                    : RiquatSunnahList(isDark: widget.isDark),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
