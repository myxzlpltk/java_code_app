import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class OrderDataEmpty extends StatelessWidget {
  final String title;
  final String? subtitle;

  const OrderDataEmpty({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetConst.bgPattern2),
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
        ),
      ),
      child: Stack(
        children: [
          ListView(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetConst.iconNote,
                  width: 150.r,
                ),
                25.verticalSpacingRadius,
                Text(
                  title,
                  style: Get.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                ...Conditional.list(
                  context: context,
                  conditionBuilder: (context) => subtitle != null,
                  widgetBuilder: (context) => [
                    10.verticalSpacingRadius,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.r),
                      child: Text(
                        subtitle!,
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  fallbackBuilder: (context) => [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
