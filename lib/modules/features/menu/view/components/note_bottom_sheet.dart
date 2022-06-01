import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:java_code_app/modules/features/menu/view/components/holder_bottom_sheet.dart';

class NoteBottomSheet extends StatelessWidget {
  final TextEditingController noteController =
      TextEditingController(text: DetailMenuController.to.note.value);

  NoteBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 19.h),
      child: Wrap(
        children: [
          const HolderBottomSheet(),
          SizedBox(height: 13.h),
          Text(
            'create_note'.tr,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: noteController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: 'add_note'.tr,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  maxLength: 100,
                ),
              ),
              SizedBox(height: 12.w),
              IconButton(
                icon: const Icon(Icons.check_circle),
                splashRadius: 20.r,
                color: blueColor,
                onPressed: () {
                  DetailMenuController.to.setNote(noteController.text);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
