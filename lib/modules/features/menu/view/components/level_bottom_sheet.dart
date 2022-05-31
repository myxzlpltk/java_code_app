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
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 19.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HolderBottomSheet(),
          SizedBox(height: 13.h),
          Text(
            'select_level'.tr,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16.h),
          Obx(
            () => Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
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
