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
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: blueColor),
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: blueColor, size: 26),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration.collapsed(
                hintText: 'search_bar'.tr,
                hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
