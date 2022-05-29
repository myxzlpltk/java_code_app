import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPromoCard extends StatelessWidget {
  final double? width;
  final double? height;
  final bool shadow;

  const ShimmerPromoCard({
    Key? key,
    this.width,
    this.height,
    this.shadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width ?? 282.w,
        height: height ?? 158.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          color: Colors.white,
          boxShadow: [
            if (shadow)
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                offset: const Offset(0, 2),
                blurRadius: 8,
              ),
          ],
        ),
      ),
    );
  }
}
