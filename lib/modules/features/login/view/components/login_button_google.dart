import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class LoginButtonGoogle extends StatelessWidget {
  final void Function()? onPressed;

  const LoginButtonGoogle({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 36.r, vertical: 14.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AssetConst.iconGoogle, width: 24.r, height: 24.r),
          const Spacer(),
          Text(
            'Login with'.tr,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.darkColor,
              height: 1.219,
            ),
          ),
          Text(
            ' Google',
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.darkColor,
              height: 1.219,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
