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
      textStyle: Get.textTheme.titleLarge,
      decoration: BoxDecoration(
        border: Border.all(color: blueColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Judul
        Text(
          'Verify order'.tr,
          style: Get.textTheme.headlineMedium,
        ),

        /// Subjudul
        Text(
          'Enter PIN code'.tr,
          style: Get.textTheme.bodySmall!.copyWith(color: greyColor2),
        ),
        24.verticalSpacingRadius,
        Row(
          children: [
            48.horizontalSpaceRadius,
            Obx(
              () => Expanded(
                /// Input PIN
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

            /// Tombol untuk menampilkan PIN
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

        /// Pesan error
        Obx(
          () => Conditional.single(
            context: context,
            conditionBuilder: (context) => errorText.value != null,
            widgetBuilder: (context) => Padding(
              padding: EdgeInsets.only(left: 15.r, right: 15.r, top: 10.r),
              child: Text(
                errorText.value!,
                style: Get.textTheme.bodySmall!.copyWith(color: redColor),
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
