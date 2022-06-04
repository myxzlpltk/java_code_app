import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/features/dashboard/controllers/order_controller.dart';
import 'package:java_code_app/modules/features/dashboard/view/components/order_data_empty.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';
import 'package:java_code_app/shared/widgets/server_error_list_view.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Material(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            color: Colors.white,
            shape: CustomShape.bottomRoundedShape,
            child: SafeArea(
              child: TabBar(
                indicatorColor: blueColor,
                indicatorWeight: 2.r,
                unselectedLabelColor: darkColor2,
                labelColor: blueColor,
                labelStyle: Get.textTheme.titleSmall,
                tabs: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    child: Tab(text: 'On going'.tr),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    child: Tab(text: 'History'.tr),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
              onRefresh: OrderController.to.fetchOnGoing,
              child: Obx(
                () => ConditionalSwitch.single(
                  context: context,
                  valueBuilder: (context) =>
                      OrderController.to.onGoingStatus.value,
                  caseBuilders: {
                    'error': (context) => const ServerErrorListView(),
                    'empty': (context) => OrderDataEmpty(
                          title: 'Already Ordered?\nTrack the order here.'.tr,
                        ),
                    'loading': (context) => ListView.separated(
                      padding: EdgeInsets.symmetric(
                            horizontal: 25.r,
                            vertical: 25.r,
                          ),
                          itemCount: 5,
                          itemBuilder: (_, i) => AspectRatio(
                            aspectRatio: 378 / 138,
                            child: RectShimmer(radius: 10.r),
                          ),
                          separatorBuilder: (_, i) => 16.verticalSpacingRadius,
                        )
                  },
                  fallbackBuilder: (context) => OrderDataEmpty(
                    title: 'Already Ordered?\nTrack the order here.'.tr,
                  ),
                ),
              ),
            ),
            Center(
              child: Text('History'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
