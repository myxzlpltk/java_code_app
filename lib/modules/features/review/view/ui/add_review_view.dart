import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/review/controllers/add_review_controller.dart';
import 'package:java_code_app/modules/features/review/view/components/add_image_button.dart';
import 'package:java_code_app/modules/features/review/view/components/image_card.dart';
import 'package:java_code_app/modules/features/review/view/components/rating_bar.dart';
import 'package:java_code_app/modules/features/review/view/components/review_type_chip.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/utils/functions/texts.dart';

class AddReviewView extends StatelessWidget {
  const AddReviewView({Key? key}) : super(key: key);

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
        title: Text('Add Review'.tr, style: Get.textTheme.titleMedium),
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
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 21.r, horizontal: 16.r),
          children: [
            /// Score
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 20.r),
              decoration: BoxDecoration(
                color: AppColor.lightColor2,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Give review'.tr,
                    style: Get.textTheme.titleSmall,
                  ),
                  13.verticalSpacingRadius,
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => RatingBar(
                            rating:
                                AddReviewController.to.selectedRating.value ??
                                    0,
                            spacing: 9.r,
                            size: 22.r,
                            onRatingChanged: AddReviewController.to.setRating,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          scoreToString(
                              AddReviewController.to.selectedRating.value ?? 0),
                          style: Get.textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            16.verticalSpacingRadius,

            /// Review form
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 20.r),
              decoration: BoxDecoration(
                color: AppColor.lightColor2,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What can be upgraded?'.tr,
                    style: Get.textTheme.titleSmall,
                  ),
                  13.verticalSpacingRadius,
                  Wrap(
                    spacing: 10.r,
                    runSpacing: 10.r,
                    children: AddReviewController.to.reviewTypes
                        .map<Widget>((e) => Obx(
                              () => ReviewTypeChip(
                                type: e,
                                isSelected: AddReviewController
                                        .to.selectedReviewType.value ==
                                    e,
                                onTap: () =>
                                    AddReviewController.to.setReviewType(e),
                              ),
                            ))
                        .toList(),
                  ),
                  22.verticalSpacingRadius,
                  Divider(
                    color: AppColor.darkColor2.withOpacity(0.25),
                    height: 1.r,
                  ),
                  18.verticalSpacingRadius,
                  Text(
                    'Write a review'.tr,
                    style: Get.textTheme.titleSmall,
                  ),
                  5.verticalSpacingRadius,
                  Form(
                    key: AddReviewController.to.formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.r,
                        horizontal: 13.r,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: AppColor.darkColor2.withOpacity(0.25),
                          width: 0.5.r,
                        ),
                      ),
                      child: TextFormField(
                        controller: AddReviewController.to.reviewController,
                        maxLines: 5,
                        style: Get.textTheme.labelMedium,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Write your review here...'.tr,
                        ),
                      ),
                    ),
                  ),
                  21.verticalSpacingRadius,
                  Obx(
                    () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          AddReviewController.to.selectedImage.value != null,
                      widgetBuilder: (context) => Padding(
                        padding: EdgeInsets.only(bottom: 20.r),
                        child: ImageCard(
                          image: AddReviewController.to.selectedImage.value!,
                          onDelete: () {
                            AddReviewController.to.selectedImage.value = null;
                          },
                        ),
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {},
                          text: 'Submit review',
                        ),
                      ),
                      14.horizontalSpaceRadius,
                      AddImageButton(
                        onPressed: AddReviewController.to.addImage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
