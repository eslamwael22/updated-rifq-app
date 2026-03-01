import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerLoading extends StatelessWidget {
  const AppShimmerLoading({
    super.key,
    this.itemCount = 5,
    this.isSliver = false,
    this.padding,
  });

  final int itemCount;
  final bool isSliver;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;

    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    final shimmerList = ListView.separated(
      padding: EdgeInsets.all(padding ?? 16),
      itemCount: itemCount,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            height: MediaQuery.sizeOf(context).height * .1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
          ),
        );
      },
    );

    if (isSliver) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: shimmerList,
        ),
      );
    }

    return shimmerList;
  }
}
