import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:java_code_app/modules/features/menu/view/components/holder_bottom_sheet.dart';
import 'package:java_code_app/modules/features/menu/view/components/variant_chip.dart';

class ToppingBottomSheet extends StatelessWidget {
  const ToppingBottomSheet({Key? key}) : super(key: key);

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
            'Choose topping'.tr,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16.h),
          Obx(
            () => Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: DetailMenuController.to.toppings
                  .map<Widget>(
                    (topping) => VariantChip(
                      text: topping.keterangan,
                      onTap: () =>
                          DetailMenuController.to.toggleTopping(topping),
                      isSelected: DetailMenuController.to.selectedToppings
                          .contains(topping),
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
