import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class HolderBottomSheet extends StatelessWidget {
  const HolderBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: greyColor3.withOpacity(0.5),
        height: 4.h,
        width: 104.w,
      ),
    );
  }
}
