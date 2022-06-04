import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RectShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;

  const RectShimmer({
    Key? key,
    this.width,
    this.height,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 45.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 5.r),
          color: Colors.white,
        ),
      ),
    );
  }
}
