import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/features/order/controllers/order_controller.dart';
import 'package:java_code_app/modules/features/order/view/components/date_picker.dart';
import 'package:java_code_app/modules/features/order/view/components/dropdown_status.dart';
import 'package:java_code_app/modules/features/order/view/components/order_card.dart';
import 'package:java_code_app/modules/features/order/view/components/order_data_empty.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/empty_data_vertical.dart';
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
                indicatorColor: AppColor.blueColor,
                indicatorWeight: 2.r,
                unselectedLabelColor: AppColor.darkColor2,
                labelColor: AppColor.blueColor,
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
            _onGoingOrders(context),
            _historyOrders(context),
          ],
        ),
      ),
    );
  }

  Widget _onGoingOrders(BuildContext context) {
    return RefreshIndicator(
      onRefresh: OrderController.to.fetchOnGoing,
      child: Obx(
        () => ConditionalSwitch.single(
          context: context,
          valueBuilder: (context) => OrderController.to.onGoingStatus.value,
          caseBuilders: {
            'error': (context) => const ServerErrorListView(),
            'empty': (context) => OrderDataEmpty(
                  title: 'Already Ordered? Track the order here.'.tr,
                ),
            'loading': (context) => ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.r,
                    vertical: 25.r,
                  ),
                  separatorBuilder: (_, i) => 16.verticalSpacingRadius,
                  itemCount: 5,
                  itemBuilder: (_, i) => AspectRatio(
                    aspectRatio: 378 / 138,
                    child: RectShimmer(radius: 10.r),
                  ),
                ),
          },
          fallbackBuilder: (context) => ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 25.r),
            separatorBuilder: (_, index) => 16.verticalSpacingRadius,
            itemCount: OrderController.to.onGoingOrders.length,
            itemBuilder: (_, index) => OrderCard(
              order: OrderController.to.onGoingOrders.elementAt(index),
              onTap: () => Get.toNamed(
                AppRoutes.detailOrderView,
                arguments: OrderController.to.onGoingOrders.elementAt(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _historyOrders(BuildContext context) {
    final Map<String, String> filterStatus = {
      'all': 'All status'.tr,
      'completed': 'Completed'.tr,
      'canceled': 'Canceled'.tr,
    };

    return RefreshIndicator(
      onRefresh: OrderController.to.fetchHistory,
      child: Obx(
        () => ConditionalSwitch.single(
          context: context,
          valueBuilder: (context) => OrderController.to.historyStatus.value,
          caseBuilders: {
            'error': (context) => const ServerErrorListView(),
            'empty': (context) => OrderDataEmpty(
                  title: 'Start placing orders.'.tr,
                  subtitle:
                      'The food you ordered will appear here so you can find your favorite menu again!'
                          .tr,
                ),
            'loading': (context) => ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.r,
                    vertical: 25.r,
                  ),
                  separatorBuilder: (_, i) => 16.verticalSpacingRadius,
                  itemCount: 5,
                  itemBuilder: (_, i) => AspectRatio(
                    aspectRatio: 378 / 138,
                    child: RectShimmer(radius: 10.r),
                  ),
                ),
          },
          fallbackBuilder: (context) => ListView(
            padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 25.r),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownStatus(
                      items: filterStatus,
                      selectedItem: OrderController.to.selectedCategory,
                      onChanged: (value) =>
                          OrderController.to.setFilter(category: value),
                    ),
                  ),
                  22.horizontalSpaceRadius,
                  Expanded(
                    child: DatePicker(
                      selectedDate: OrderController.to.selectedDateRange,
                      onChanged: (value) =>
                          OrderController.to.setFilter(dateRange: value),
                    ),
                  ),
                ],
              ),
              25.verticalSpacingRadius,
              ...Conditional.list(
                context: context,
                conditionBuilder: (context) =>
                    OrderController.to.historyOrderFiltered.isEmpty,
                widgetBuilder: (context) => [
                  100.verticalSpacingRadius,
                  const EmptyDataVertical(),
                  100.verticalSpacingRadius,
                ],
                fallbackBuilder: (context) =>
                    OrderController.to.historyOrderFiltered
                        .map(
                          (order) => Padding(
                            padding: EdgeInsets.only(bottom: 16.r),
                            child: OrderCard(
                              order: order,
                              onOrderAgain: () =>
                                  OrderController.to.onOrderAgain(order),
                              onTap: () => Get.toNamed(
                                AppRoutes.detailOrderView,
                                arguments: order,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
