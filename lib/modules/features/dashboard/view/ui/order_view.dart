import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Material(
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30.w),
                ),
              ),
              child: TabBar(
                indicatorColor: blueColor,
                indicatorWeight: 2.h,
                unselectedLabelColor: darkColor2,
                labelColor: blueColor,
                labelStyle: Theme.of(context).textTheme.titleMedium,
                tabs: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Tab(text: 'On going'.tr),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Tab(text: 'History'.tr),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Text('On going'.tr),
              ),
              Center(
                child: Text('History'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
