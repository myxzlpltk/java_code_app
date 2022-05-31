import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:java_code_app/shared/widgets/quantity_counter.dart';

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
      backgroundColor: lightColor2,
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
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 45.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          DetailMenuController.to.menu.value!.nama,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: blueColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Material(
                        child: QuantityCounter(
                          quantity: 1,
                          onIncrement: DetailMenuController.to.onIncrement,
                          onDecrement: DetailMenuController.to.onDecrement,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
