import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/shared/widgets/quantity_counter.dart';
import 'package:java_code_app/shared/widgets/tile.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';

class DetailMenuView extends StatelessWidget {
  const DetailMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailMenuController());

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 32.w),
          onPressed: () => Get.back(closeOverlays: true),
        ),
        centerTitle: true,
        title: Text(
          'detail_menu'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.w),
          ),
        ),
      ),
      backgroundColor: lightColor3,
      body: Column(
        children: [
          SizedBox(height: 25.h),
          Center(
            child: Image.network(
              DetailMenuController.to.menu.value!.foto,
              height: 181.h,
              width: 234.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 25.h),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 45.h),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DetailMenuController.to.menu.value!.nama,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: blueColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              DetailMenuController.to.menu.value!.deskripsi,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Material(
                        child: Obx(
                          () => QuantityCounter(
                            quantity: DetailMenuController.to.quantity.value,
                            onIncrement: DetailMenuController.to.onIncrement,
                            onDecrement: DetailMenuController.to.onDecrement,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Divider(color: darkColor2.withOpacity(0.25), height: 1),
                  Tile(
                    icon: AssetConst.iconPrice,
                    title: 'price'.tr,
                    message:
                        DetailMenuController.to.menu.value!.harga.toRupiah(),
                    messageStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: blueColor),
                  ),
                  Obx(
                    () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          DetailMenuController.to.levels.isNotEmpty,
                      widgetBuilder: (context) => Wrap(
                        children: [
                          Divider(
                            color: darkColor2.withOpacity(0.25),
                            height: 1,
                          ),
                          Tile(
                            icon: AssetConst.iconLevel,
                            title: 'level'.tr,
                            message: DetailMenuController
                                .to.selectedLevel.value!.keterangan,
                            onTap: DetailMenuController.to.openLevelBottomSheet,
                          ),
                        ],
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                  Obx(
                    () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          DetailMenuController.to.toppings.isNotEmpty,
                      widgetBuilder: (context) => Wrap(
                        children: [
                          Divider(
                            color: darkColor2.withOpacity(0.25),
                            height: 1,
                          ),
                          Tile(
                            icon: AssetConst.iconTopping,
                            title: 'topping'.tr,
                            message: DetailMenuController
                                .to.selectedTopping.value!.keterangan,
                            onTap:
                                DetailMenuController.to.openToppingBottomSheet,
                          ),
                        ],
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                  Divider(color: darkColor2.withOpacity(0.25), height: 1),
                  Obx(
                    () => Tile(
                      icon: AssetConst.iconEdit,
                      title: 'note'.tr,
                      message: DetailMenuController.to.note.isNotEmpty
                          ? DetailMenuController.to.note.value
                          : 'add_note'.tr,
                      onTap: DetailMenuController.to.openNoteBottomSheet,
                    ),
                  ),
                  Divider(color: darkColor2.withOpacity(0.25), height: 1),
                  SizedBox(height: 40.h),
                  Obx(
                    () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          DetailMenuController.to.status.value == 'success',
                      widgetBuilder: (context) => PrimaryButton(
                        text: 'add_to_order'.tr,
                        onPressed: DetailMenuController.to.addToOrder,
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
