import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'app_colors.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final ShimmerDirection direction;
  final Duration period;

  const CustomShimmerWidget({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 2000),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      direction: direction,
      period: period,
      enabled: true,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
        color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10))
        ),
      ),
    );
  }
}
