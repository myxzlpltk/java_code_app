import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:pinput/pinput.dart';

class PinDialog extends StatelessWidget {
  const PinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool obscure = RxBool(false);
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: Theme.of(context).textTheme.titleLarge,
      decoration: BoxDecoration(
        border: Border.all(color: blueColor),
        borderRadius: BorderRadius.circular(10.w),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'verify_order'.tr,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          'enter_pin_code'.tr,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: greyColor2),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            SizedBox(width: 48.r),
            Obx(
              () => Expanded(
                child: Pinput(
                  length: 6,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  obscureText: obscure.value,
                  onSubmitted: (pin) {
                    print('On Submitted   Pin: $pin');
                  },
                  onCompleted: (pin) {
                    print('On Completed Pin: $pin');
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
                  color: blueColor,
                  size: 20.r,
                ),
                onPressed: () {
                  obscure.value = !obscure.value;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
