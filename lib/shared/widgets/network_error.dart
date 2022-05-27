import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Padding(
          padding: EdgeInsets.all(32.r),
          child: Column(
            children: [
              const Spacer(),
              SvgPicture.asset(
                AssetConst.iconNoInternet,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              Text(
                'not_connected'.tr,
                style: Theme.of(context).textTheme.headline5,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => AppSettings.openDeviceSettings(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    const Icon(Icons.settings, color: darkColor),
                    SizedBox(width: 16.w),
                    Text(
                      'open_settings'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w400,
                        color: darkColor,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
              ,
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
