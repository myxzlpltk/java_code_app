import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/models/voucher.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;
  final bool isSelected;
  final void Function()? onTap;
  final void Function(bool?)? onChanged;

  const VoucherCard({
    Key? key,
    required this.voucher,
    required this.isSelected,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: lightColor2,
        borderRadius: BorderRadius.circular(15.w),
        boxShadow: [
          BoxShadow(
            color: darkColor2.withOpacity(0.35),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.w),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.w),
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Row(
                children: [
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Text(
                      voucher.nama,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Checkbox(
                    value: isSelected,
                    onChanged: onChanged,
                    checkColor: blueColor,
                    fillColor: MaterialStateProperty.all(lightColor2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.w)),
                    side: MaterialStateBorderSide.resolveWith(
                        (_) => const BorderSide(color: darkColor2, width: 1)),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              SizedBox(height: 12.h),
              Hero(
                tag: 'voucher-image-${voucher.id_voucher}',
                child: Material(
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.w),
                      image: DecorationImage(
                        image: NetworkImage(voucher.info_voucher),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const AspectRatio(aspectRatio: 379 / 177),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
