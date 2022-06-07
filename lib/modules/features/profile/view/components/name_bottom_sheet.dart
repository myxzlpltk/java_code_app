import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/features/menu/view/components/holder_bottom_sheet.dart';

class NameBottomSheet extends StatefulWidget {
  final String nama;

  const NameBottomSheet({Key? key, required this.nama}) : super(key: key);

  @override
  State<NameBottomSheet> createState() => _NameBottomSheetState();
}

class _NameBottomSheetState extends State<NameBottomSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.nama);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Wrap(
        children: [
          const HolderBottomSheet(),
          13.verticalSpacingRadius,
          Text('Name'.tr, style: Get.textTheme.headlineSmall),
          13.verticalSpacingRadius,
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: Get.textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: 'Name'.tr,
                    hintStyle: Get.textTheme.bodySmall,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: blueColor, width: 2),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: blueColor, width: 2),
                    ),
                  ),
                  maxLength: 100,
                  autofocus: true,
                ),
              ),
              12.verticalSpacingRadius,
              IconButton(
                icon: const Icon(Icons.check_circle),
                splashRadius: 20.r,
                color: blueColor,
                onPressed: () => Get.back(result: controller.text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
