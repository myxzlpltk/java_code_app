import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/shared/widgets/quantity_counter.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;
  final int? price;
  final bool isSimple;
  final int quantity;
  final String note;
  final void Function()? onTap;
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  final void Function(String)? onNoteChanged;

  const MenuCard({
    Key? key,
    required this.menu,
    this.price,
    this.quantity = 0,
    this.note = '',
    this.onTap,
    this.onIncrement,
    this.onDecrement,
    this.onNoteChanged,
  })  : isSimple = false,
        super(key: key);

  const MenuCard.simple({
    Key? key,
    required this.menu,
    this.price,
    this.quantity = 0,
    this.note = '',
    this.onTap,
    this.onIncrement,
    this.onDecrement,
    this.onNoteChanged,
  })  : isSimple = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: AppColor.lightColor2,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.darkColor2.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Row(
          children: [
            /// Gambar menu
            Container(
              height: isSimple ? 75.r : 90.r,
              width: isSimple ? 75.r : 90.r,
              margin: EdgeInsets.only(right: 12.r),
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.lightColor,
              ),
              child: Hero(
                tag: 'menu-${menu.id_menu}',
                child: Image.network(
                  menu.foto,
                  fit: BoxFit.contain,
                  errorBuilder: (context, _, __) => Image.network(
                    AppConst.defaultMenuPhoto,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            /// Informasi menu
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Nama menu
                  Text(
                    menu.nama,
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  /// Harga menu
                  Text(
                    (price ?? menu.harga).toRupiah(),
                    style: Get.textTheme.bodyMedium!.copyWith(
                        color: AppColor.blueColor, fontWeight: FontWeight.bold),
                  ),
                  5.verticalSpacingRadius,

                  /// Catatan menu
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) => !isSimple,
                    widgetBuilder: (context) => Row(
                      children: [
                        /// Icon edit
                        SvgPicture.asset(AssetConst.iconEdit, height: 12.r),
                        7.horizontalSpaceRadius,

                        /// Text field
                        Expanded(
                          child: TextFormField(
                            initialValue: note,
                            style: Get.textTheme.labelMedium,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Add note'.tr,
                              border: InputBorder.none,
                            ),
                            onChanged: onNoteChanged,
                          ),
                        ),
                      ],
                    ),
                    fallbackBuilder: (context) => const SizedBox(),
                  ),
                ],
              ),
            ),

            /// Informasi counter kuantitas
            Conditional.single(
              context: context,
              conditionBuilder: (context) => !isSimple,
              widgetBuilder: (context) => Container(
                height: 75.r,
                padding: EdgeInsets.only(left: 12.r, right: 5.r),
                child: InkWell(
                  onTap: () {},
                  splashFactory: NoSplash.splashFactory,
                  child: QuantityCounter(
                    quantity: quantity,
                    onIncrement: onIncrement,
                    onDecrement: onDecrement,
                  ),
                ),
              ),
              fallbackBuilder: (context) => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
