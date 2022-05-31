import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/shared/widgets/quantity_counter.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;
  final bool simple;
  final void Function()? onTap;
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  final void Function(String)? onNoteChanged;

  const MenuCard({
    Key? key,
    required this.menu,
    this.simple = false,
    this.onTap,
    this.onIncrement,
    this.onDecrement,
    this.onNoteChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.w),
      child: Ink(
        padding: EdgeInsets.all(7.w),
        decoration: BoxDecoration(
          color: lightColor2,
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
              color: darkColor2.withOpacity(0.35),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Row(
          children: [
            /* Image */
            Container(
              height: 75.w,
              width: 75.w,
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: lightColor,
              ),
              child: Image.network(
                menu.foto,
                fit: BoxFit.contain,
                height: 75.w,
                width: 75.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    menu.harga.toRupiah(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: blueColor, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  if (!simple)
                    Row(
                      children: [
                        SvgPicture.asset(AssetConst.iconEdit, height: 12.h),
                        SizedBox(width: 7.w),
                        SizedBox(
                          width: 150.w,
                          child: TextField(
                            style: Theme.of(context).textTheme.labelMedium,
                            decoration: InputDecoration.collapsed(
                              hintText: 'add_note'.tr,
                              border: InputBorder.none,
                            ),
                            onChanged: onNoteChanged,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            if (!simple) ...[
              QuantityCounter(
                quantity: 1,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
              SizedBox(width: 5.w),
            ]
          ],
        ),
      ),
    );
  }
}
