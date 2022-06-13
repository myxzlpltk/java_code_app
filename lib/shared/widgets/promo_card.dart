import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:java_code_app/utils/extensions/string_extension.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;
  final Function()? onTap;
  final bool shadow;

  const PromoCard({
    Key? key,
    required this.promo,
    this.onTap,
    this.shadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'promo_card_${promo.id_promo}',
      child: Container(
        width: 282.r,
        height: 158.r,
        decoration: BoxDecoration(
          color: AppColor.blueColor.withOpacity(0.9),
          image: DecorationImage(
            image: promo.foto == null
                ? const AssetImage(AssetConst.bgPromo)
                : CachedNetworkImageProvider(promo.foto!)
                    as ImageProvider<Object>,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColor.blueColor.withOpacity(0.9),
              BlendMode.srcATop,
            ),
          ),
          borderRadius: BorderRadius.circular(15.r),
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
            borderRadius: BorderRadius.circular(15.r),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// Nominal promo
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) => promo.type == 'diskon',
                    widgetBuilder: (context) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          promo.typeLabel,
                          style: Get.textTheme.titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                        5.horizontalSpaceRadius,
                        Text(
                          promo.amountLabel,
                          style: GoogleFonts.montserrat(
                            fontSize: 35.sp,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1.r
                              ..color = Colors.white,
                          ),
                        ),
                      ],
                    ),
                    fallbackBuilder: (context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          promo.typeLabel,
                          style: Get.textTheme.titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                        5.verticalSpacingRadius,
                        Text(
                          promo.amountLabel,
                          style: GoogleFonts.montserrat(
                            fontSize: 25.sp,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1.r
                              ..color = Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  5.verticalSpacingRadius,

                  /// Judul diskon atau voucher
                  Text(
                    promo.nama.toTitleCase(),
                    style: Get.textTheme.labelMedium!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
