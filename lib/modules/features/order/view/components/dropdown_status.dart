import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class DropdownStatus extends StatelessWidget {
  final Map<String, String> items;
  final String selectedItem;
  final void Function(String?)? onChanged;

  const DropdownStatus({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30.r),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<String>(
          isDense: true,
          isExpanded: true,
          value: selectedItem,
          style: Get.textTheme.titleSmall,
          borderRadius: BorderRadius.circular(30.r),
          alignment: Alignment.centerLeft,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 4.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: blueColor, width: 1.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: blueColor, width: 1.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: blueColor, width: 1.r),
            ),
          ),
          items: items.entries
              .map<DropdownMenuItem<String>>(
                (entry) => DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
