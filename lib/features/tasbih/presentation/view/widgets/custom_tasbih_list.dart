import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_cubit.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/custom_tasbih.dart';

class CustomTasbihList extends StatefulWidget {
  const CustomTasbihList({
    super.key,
  });

  @override
  State<CustomTasbihList> createState() => _CustomTasbihListState();
}

class _CustomTasbihListState extends State<CustomTasbihList> {
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .07,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 8,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              currentIndex.value = index;
              BlocProvider.of<TasbihCubit>(
                context,
              ).changeZakar(
                tasbihList[index],
              );
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * .35,

                child: CustomTasbih(
                  tasbih: tasbihList[index],
                  index: index,
                  currentIndex: currentIndex,
                ),
              ),
            ),
          ),
          itemCount: tasbihList.length,
        ),
      ),
    );
  }
}

List<String> tasbihList = [
  'سبحان الله',
  'الحمد لله',
  'لا إله إلا الله',
  'الله أكبر',
  'لا حول ولا قوة إلا بالله',
  'سبحان الله العظيم',
  'سبحان الله وبحمده',
  'اللهم صلِ على محمد',
  'اللهم اغفر لي',
  'اللهم اهدني',
  'أستغفر الله',
  'سبحان ربي الأعلى',
  'سبحان ربي العظيم',
  'سبحان ربي وبحمده',
];
