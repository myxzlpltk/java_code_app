import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/modules/features/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          children: [
            SizedBox(height: 100),
            Text('home_page'.tr, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
