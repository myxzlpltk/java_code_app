import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';

class ImageCard extends StatelessWidget {
  final File image;
  final void Function() onDelete;

  const ImageCard({
    Key? key,
    required this.image,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.file(
          image,
          width: 100.r,
          height: 100.r,
          fit: BoxFit.cover,
        ),
        10.verticalSpacingRadius,
        SizedBox(
          width: 100.r,
          child: PrimaryButton.compact(
            onPressed: onDelete,
            text: 'Delete'.tr,
          ),
        ),
      ],
    );
  }
}
