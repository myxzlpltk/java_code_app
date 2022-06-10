import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/models/voucher.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;
  final bool isSelected;
  final void Function() onTap;
  final void Function(bool?) onChanged;

  const VoucherCard({
    Key? key,
    required this.voucher,
    required this.isSelected,
    required this.onTap,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.lightColor2,
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(15.r),
      child: InkWell(
        onTap: () => onChanged(!isSelected),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            12.verticalSpacingRadius,
            Row(
              children: [
                15.horizontalSpaceRadius,

                /// Nama voucher
                Expanded(
                  child: Text(
                    voucher.nama,
                    style: Get.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                10.horizontalSpaceRadius,

                /// Checkbox
                Checkbox(
                  value: isSelected,
                  onChanged: onChanged,
                  checkColor: AppColor.blueColor,
                  fillColor: MaterialStateProperty.all(AppColor.lightColor2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  side: MaterialStateBorderSide.resolveWith(
                    (_) =>
                        const BorderSide(color: AppColor.darkColor2, width: 1),
                  ),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                15.horizontalSpaceRadius
              ],
            ),
            12.verticalSpacingRadius,

            /// Gambar voucher
            Hero(
              tag: 'voucher-image-${voucher.id_voucher}',
              child: Material(
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: NetworkImage(voucher.info_voucher),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(15.r),
                    child: const AspectRatio(aspectRatio: 379 / 177),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
