import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/features/azkar/data/models/counter_model.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/appbar_header.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/counter_row.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar({super.key, this.sizedBox = true});
  final bool sizedBox;
  final List<CounterModel> items = [
    CounterModel(count: 11, title: 'الفئات'),
    CounterModel(count: 0, title: 'مكتملة اليوم'),
    CounterModel(count: 0, title: 'المفضله'),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 50.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppbarHeader(),
          SizedBox(height: 20.h),
          CounterRow(
            items: items,
          ),
          sizedBox
              ? SizedBox(height: 12.h)
              : SizedBox(height: 0),
        ],
      ),
    );
  }
}