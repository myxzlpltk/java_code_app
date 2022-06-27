import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/review/view/components/review_card.dart';
import 'package:java_code_app/modules/models/review.dart';
import 'package:java_code_app/shared/styles/shapes.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 30.r,
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
          onPressed: () => Get.back(closeOverlays: true),
        ),
        centerTitle: true,
        title: Text('List review'.tr, style: Get.textTheme.titleMedium),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetConst.bgPattern2),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
          ),
        ),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 21.r, horizontal: 25.r),
          separatorBuilder: (context, index) => 16.verticalSpacingRadius,
          itemCount: 4,
          itemBuilder: (context, _) => ReviewCard(
            review: Review.dummy,
            onTap: () => Get.toNamed(AppRoutes.replyReviewView),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addReviewView),
        backgroundColor: AppColor.blueColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
