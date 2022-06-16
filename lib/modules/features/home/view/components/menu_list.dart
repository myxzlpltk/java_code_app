import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/shared/widgets/empty_data_vertical.dart';
import 'package:java_code_app/shared/widgets/menu_card.dart';

class MenuList extends StatelessWidget {
  final List<Menu> data;

  const MenuList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => data.isNotEmpty,
      widgetBuilder: (context) => Wrap(
        runSpacing: 17.r,
        children: data.map<Widget>((menu) {
          return MenuCard.simple(
            menu: menu,
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.toNamed(AppRoutes.detailMenuView, arguments: menu);
            },
          );
        }).toList(),
      ),
      fallbackBuilder: (context) => EmptyDataVertical(width: 100.r),
    );
  }
}
