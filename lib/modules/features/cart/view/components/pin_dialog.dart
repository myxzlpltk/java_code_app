import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:pinput/pinput.dart';

class PinDialog extends StatelessWidget {
  final RxBool obscure = RxBool(true);
  final RxnString errorText = RxnString();
  final TextEditingController controller = TextEditingController();
  final String? Function(String?) onCheckPin;

  PinDialog({
    Key? key,
    required this.onCheckPin,
  }) : super(key: key);

  void processPin(String? pin) async {
    await Future.delayed(const Duration(milliseconds: 500));

    errorText.value = onCheckPin(pin);

    if (errorText.value != null) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Verify order'.tr,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          'Enter PIN code'.tr,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: greyColor2),
        ),
        SizedBox(height: 24.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 48.r),
            Obx(
              () => Expanded(
                child: Pinput(
                  controller: controller,
                  showCursor: false,
                  length: 6,
                  autofocus: true,
                  closeKeyboardWhenCompleted: false,
                  defaultPinTheme: defaultPinTheme,
                  obscureText: obscure.value,
                  onSubmitted: processPin,
                  onCompleted: processPin,
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
        Obx(
          () => Conditional.single(
            context: context,
            conditionBuilder: (context) => errorText.value != null,
            widgetBuilder: (context) => Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
              child: Text(
                errorText.value!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: redColor),
                textAlign: TextAlign.center,
              ),
            ),
            fallbackBuilder: (context) => const SizedBox(),
          ),
        ),
      ],
    );
  }
}
