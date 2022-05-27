import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';
import 'package:java_code_app/utils/extensions/string_case_extension.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;
  final Function()? onTap;
  final double? width;
  final double? height;
  final bool shadow;

  const PromoCard({
    Key? key,
    required this.promo,
    this.onTap,
    this.width,
    this.height,
    this.shadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 282.w,
      height: height ?? 158.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: promo.foto == null
              ? const AssetImage(AssetConst.bgPromo)
              : NetworkImage(promo.foto!) as ImageProvider<Object>,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            blueColor.withOpacity(0.9),
            BlendMode.srcATop,
          ),
        ),
        borderRadius: BorderRadius.circular(15.w),
        boxShadow: [
          if (shadow)
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    promo.type.tr.toTitleCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    promo.type == 'diskon'
                        ? '${promo.diskon}%'
                        : promo.nominal!.toShortK(),
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1.5
                            ..color = Colors.white,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                promo.nama.toTitleCase(),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
