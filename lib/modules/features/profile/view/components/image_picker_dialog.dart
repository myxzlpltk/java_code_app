import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class ImagePickerDialog extends StatelessWidget {
  const ImagePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        children: [
          Text('Select image source', style: Get.textTheme.titleMedium),
          10.verticalSpacingRadius,
          TextButton(
            onPressed: () => Get.back(result: ImageSource.gallery),
            child: Row(
              children: [
                const Icon(Icons.image, color: darkColor),
                16.horizontalSpaceRadius,
                Text('Gallery'.tr, style: Get.textTheme.bodySmall),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: ImageSource.camera),
            child: Row(
              children: [
                const Icon(Icons.camera, color: darkColor),
                16.horizontalSpaceRadius,
                Text('Camera'.tr, style: Get.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
