import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';
import 'package:java_code_app/utils/extensions/string_case_extension.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  const PromoCard(this.promo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        width: 282.w,
        height: 158.h,
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
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promo.type.toTitleCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
                SizedBox(width: 5.w),
                Stack(
                  children: [
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
    );
  }
}
