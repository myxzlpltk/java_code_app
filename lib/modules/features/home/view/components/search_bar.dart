import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class SearchBar extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchBar({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 10.r),
      decoration: BoxDecoration(
        border: Border.all(color: blueColor),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: blueColor, size: 30.r),
          10.horizontalSpaceRadius,
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: Get.textTheme.headlineSmall,
              decoration: InputDecoration.collapsed(
                hintText: 'Search'.tr,
                hintStyle: Get.textTheme.headlineSmall!.copyWith(
                  color: const Color(0xFFAAAAAA),
                ),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
        ],
      ),
    );
  }
}
