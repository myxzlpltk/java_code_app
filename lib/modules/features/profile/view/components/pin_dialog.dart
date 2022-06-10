import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:pinput/pinput.dart';

class PinDialog extends StatefulWidget {
  const PinDialog({Key? key}) : super(key: key);

  @override
  State<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<PinDialog> {
  final RxBool obscure = RxBool(true);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: Get.textTheme.titleLarge,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.blueColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Update PIN'.tr, style: Get.textTheme.headlineSmall),
        24.verticalSpacingRadius,
        Row(
          children: [
            48.horizontalSpaceRadius,
            Expanded(
              child: Obx(
                () => Pinput(
                  controller: controller,
                  showCursor: false,
                  length: 6,
                  autofocus: true,
                  closeKeyboardWhenCompleted: false,
                  defaultPinTheme: defaultPinTheme,
                  errorTextStyle: Get.textTheme.bodySmall!
                      .copyWith(color: AppColor.redColor),
                  obscureText: obscure.value,
                  validator: (String? pin) {
                    if (pin?.length != 6) {
                      return 'PIN must be 6 digits long'.tr;
                    }
                    return null;
                  },
                  onSubmitted: (String? pin) {
                    if (pin?.length == 6) {
                      Get.back(result: controller.text);
                    }
                  },
                ),
              ),
            ),
            Obx(
              () => IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                splashRadius: 24.r,
                icon: Icon(
                  obscure.value ? Icons.visibility : Icons.visibility_off,
                  color: AppColor.blueColor,
                  size: 20.r,
                ),
                onPressed: () => obscure.value = !obscure.value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
