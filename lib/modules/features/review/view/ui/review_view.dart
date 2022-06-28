import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/review/controllers/review_controller.dart';
import 'package:java_code_app/modules/features/review/view/components/review_card.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/empty_data_list_view.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';
import 'package:java_code_app/shared/widgets/server_error_list_view.dart';

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
      body: RefreshIndicator(
        onRefresh: ReviewController.to.fetchReview,
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetConst.bgPattern2),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
            ),
          ),
          child: Obx(
            () => ConditionalSwitch.single<String>(
              context: context,
              valueBuilder: (context) => ReviewController.to.status.value,
              caseBuilders: {
                'loading': (context) => ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: 21.r, horizontal: 25.r),
                      separatorBuilder: (context, index) =>
                          16.verticalSpacingRadius,
                      itemCount: 4,
                      itemBuilder: (context, index) => RectShimmer(
                        height: 62.r,
                        radius: 10.r,
                      ),
                    ),
                'empty': (context) => const EmptyDataListView(),
                'error': (context) => const ServerErrorListView(),
              },
              fallbackBuilder: (context) => ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 21.r, horizontal: 25.r),
                separatorBuilder: (context, index) => 16.verticalSpacingRadius,
                itemCount: ReviewController.to.listReview.length,
                itemBuilder: (context, index) => ReviewCard(
                  review: ReviewController.to.listReview[index],
                  onTap: () => Get.toNamed(
                    AppRoutes.replyReviewView,
                    arguments: ReviewController.to.listReview[index],
                  ),
                ),
              ),
            ),
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
