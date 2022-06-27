import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/review/view/components/rating_bar.dart';
import 'package:java_code_app/modules/models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 13.r, horizontal: 20.r),
        decoration: BoxDecoration(
          color: AppColor.lightColor2,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 5.r, // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetConst.iconDate,
                        width: 13.r,
                        height: 13.r,
                      ),
                      7.horizontalSpaceRadius,
                      Flexible(
                        child: Text(
                          review.type,
                          style: Get.textTheme.titleSmall!.copyWith(
                            color: AppColor.blueColor,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      11.horizontalSpaceRadius,
                      RatingBar(rating: review.score, spacing: 5.r, size: 12.r),
                    ],
                  ),
                  Text(
                    review.review,
                    style: Get.textTheme.labelMedium!.copyWith(
                      color: AppColor.darkColor3,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            20.horizontalSpaceRadius,
            IconButton(
              onPressed: () {},
              splashRadius: 30.r,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                AssetConst.iconReply,
                width: 22.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
