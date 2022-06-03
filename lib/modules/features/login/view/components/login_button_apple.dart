import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class LoginButtonApple extends StatelessWidget {
  final void Function()? onPressed;

  const LoginButtonApple({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: darkColor,
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 14.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AssetConst.iconApple, width: 24.w, height: 24.h),
          const Spacer(),
          Text(
            'Login with'.tr,
            style: GoogleFonts.montserrat(
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w400,
              height: 1.219,
            ),
          ),
          Text(
            ' Apple',
            style: GoogleFonts.montserrat(
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w600,
              height: 1.219,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
