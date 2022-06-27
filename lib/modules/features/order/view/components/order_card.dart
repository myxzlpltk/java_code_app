import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/models/order.dart';
import 'package:java_code_app/shared/widgets/outlined_primary_button.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final void Function()? onTap;
  final void Function()? onOrderAgain;

  const OrderCard({
    Key? key,
    required this.order,
    this.onTap,
    this.onOrderAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: AppColor.lightColor2,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
              color: AppColor.darkColor2.withOpacity(0.3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Hero(
                tag: 'order-${order.id_order}',
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColor.lightColor,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: order.menu.isNotEmpty
                          ? order.menu.first.foto ?? AppConst.defaultMenuPhoto
                          : AppConst.defaultMenuPhoto,
                      fit: BoxFit.contain,
                      height: 75.r,
                      width: 75.r,
                      errorWidget: (context, _, __) => CachedNetworkImage(
                        imageUrl: AppConst.defaultMenuPhoto,
                        fit: BoxFit.contain,
                        height: 75.r,
                        width: 75.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            12.horizontalSpaceRadius,
            Flexible(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.verticalSpacingRadius,

                  /// Status order
                  Row(
                    children: [
                      ConditionalSwitch.single<int>(
                        context: context,
                        valueBuilder: (context) => order.status,
                        caseBuilders: {
                          0: (context) => Icon(
                                Icons.access_time,
                                color: AppColor.yellowColor,
                                size: 16.r,
                              ),
                          1: (context) => Icon(
                                Icons.access_time,
                                color: AppColor.yellowColor,
                                size: 16.r,
                              ),
                          2: (context) => Icon(
                                Icons.access_time,
                                color: AppColor.yellowColor,
                                size: 16.r,
                              ),
                          3: (context) => Icon(
                                Icons.check,
                                color: AppColor.greenColor,
                                size: 16.r,
                              ),
                          4: (context) => Icon(
                                Icons.close,
                                color: AppColor.redColor,
                                size: 16.r,
                              ),
                        },
                        fallbackBuilder: (context) => const SizedBox(),
                      ),
                      5.horizontalSpaceRadius,
                      Expanded(
                        child: ConditionalSwitch.single<int>(
                          context: context,
                          valueBuilder: (context) => order.status,
                          caseBuilders: {
                            0: (context) => Text(
                                  'In queue'.tr,
                                  style: Get.textTheme.labelMedium!
                                      .copyWith(color: AppColor.yellowColor),
                                ),
                            1: (context) => Text(
                                  'Preparing'.tr,
                                  style: Get.textTheme.labelMedium!
                                      .copyWith(color: AppColor.yellowColor),
                                ),
                            2: (context) => Text(
                                  'Ready'.tr,
                                  style: Get.textTheme.labelMedium!
                                      .copyWith(color: AppColor.yellowColor),
                                ),
                            3: (context) => Text(
                                  'Completed'.tr,
                                  style: Get.textTheme.labelMedium!
                                      .copyWith(color: AppColor.greenColor),
                                ),
                            4: (context) => Text(
                                  'Canceled'.tr,
                                  style: Get.textTheme.labelMedium!
                                      .copyWith(color: AppColor.redColor),
                                ),
                          },
                          fallbackBuilder: (context) => const SizedBox(),
                        ),
                      ),
                      Text(
                        DateFormat('dd MMMM yyyy', 'id').format(order.tanggal),
                        style: Get.textTheme.labelMedium!
                            .copyWith(color: AppColor.greyColor),
                      ),
                    ],
                  ),
                  5.verticalSpacingRadius,

                  /// Menu name
                  Text(
                    order.menu.map((e) => e.nama).join(', '),
                    style: Get.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  5.verticalSpacingRadius,

                  /// Price
                  Row(
                    children: [
                      Text(
                        order.total_bayar.toRupiah(),
                        style: Get.textTheme.labelLarge!
                            .copyWith(color: AppColor.blueColor),
                      ),
                      5.horizontalSpaceRadius,
                      Text(
                        '(${order.menu.length} Menu)',
                        style: Get.textTheme.labelLarge!
                            .copyWith(color: AppColor.greyColor),
                      ),
                    ],
                  ),

                  /// Button
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        order.status == 3 || order.status == 4,
                    widgetBuilder: (context) => Wrap(
                      spacing: 15.r,
                      children: [
                        if (order.status == 3)
                          Padding(
                            padding: EdgeInsets.only(top: 10.r, bottom: 5.r),
                            child: OutlinedPrimaryButton.compact(
                              text: 'Give review'.tr,
                              onPressed: () {},
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.r, bottom: 5.r),
                          child: PrimaryButton.compact(
                            text: 'Order again'.tr,
                            onPressed: onOrderAgain,
                          ),
                        ),
                      ],
                    ),
                    fallbackBuilder: (context) => const SizedBox(),
                  ),
                ],
              ),
            ),
            5.horizontalSpaceRadius,
          ],
        ),
      ),
    );
  }
}
