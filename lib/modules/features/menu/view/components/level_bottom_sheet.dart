import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:java_code_app/modules/features/menu/view/components/holder_bottom_sheet.dart';
import 'package:java_code_app/modules/features/menu/view/components/variant_chip.dart';

class LevelBottomSheet extends StatelessWidget {
  const LevelBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HolderBottomSheet(),
          13.verticalSpacingRadius,
          Text(
            'Choose level'.tr,
            style: Get.textTheme.headlineSmall,
          ),
          16.verticalSpacingRadius,
          Obx(
            () => Wrap(
              spacing: 12.r,
              runSpacing: 12.r,
              children: DetailMenuController.to.levels
                  .map<Widget>(
                    (level) => VariantChip(
                      text: level.keterangan,
                      onTap: () => DetailMenuController.to.setLevel(level),
                      isSelected:
                          level == DetailMenuController.to.selectedLevel.value,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
