import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPromoCard extends StatelessWidget {
  const ShimmerPromoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 282.w,
        height: 158.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          color: Colors.white,
        ),
      ),
    );
  }
}
