import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class AddImageButton extends StatelessWidget {
  final void Function()? onPressed;

  const AddImageButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.standard,
        primary: Colors.white,
        elevation: 3,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size(40.r, 40.r),
        padding: EdgeInsets.symmetric(
          horizontal: 14.r,
          vertical: 14.r,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.darkBlueColor, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: SvgPicture.asset(
        AssetConst.iconAddImage,
        width: 18.r,
        height: 18.r,
      ),
    );
  }
}
