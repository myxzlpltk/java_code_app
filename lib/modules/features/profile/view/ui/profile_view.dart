import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/profile/controllers/profile_controller.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/shared/widgets/tile_option.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Profile'.tr, style: Get.textTheme.titleMedium),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: RefreshIndicator(
        onRefresh: ProfileController.to.loadData,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetConst.bgPattern2),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
            children: [
              /// Profile icon
              Center(
                child: Container(
                  width: 170.r,
                  height: 170.r,
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AssetConst.bgProfile),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Material(
                    color: blueColor,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                        child: Text(
                          'Ubah',
                          style: Get.textTheme.labelMedium!
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              20.verticalSpacingRadius,

              /// Verifikasi KTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, color: greenColor, size: 20.r),
                  8.horizontalSpaceRadius,
                  Text(
                    'Kamu sudah verifikasi KTP',
                    style:
                        Get.textTheme.labelMedium!.copyWith(color: blueColor),
                  ),
                ],
              ),
              20.verticalSpacingRadius,

              /// Info akun
              Padding(
                padding: EdgeInsets.only(left: 20.r),
                child: Text(
                  'Info akun',
                  style: Get.textTheme.titleMedium!.copyWith(color: blueColor),
                ),
              ),
              14.verticalSpacingRadius,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: lightColor2,
                ),
                child: Column(
                  children: [
                    TileOption(
                      title: 'Nama',
                      message: 'Fajar',
                      onTap: () {},
                    ),
                    TileOption(
                      title: 'Tanggal Lahir',
                      message: '01/03/1993',
                      onTap: () {},
                    ),
                    TileOption(
                      title: 'No.Telepon',
                      message: '0822-4111-400',
                      onTap: () {},
                    ),
                    TileOption(
                      title: 'Email',
                      message: 'lorem.ipsum@gmail.com',
                      onTap: () {},
                    ),
                    TileOption(
                      title: 'Ubah PIN',
                      message: '*********',
                      onTap: () {},
                    ),
                    TileOption(
                      title: 'Ganti Bahasa',
                      message: 'Indonesia',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              18.verticalSpacingRadius,

              /// Penilaian
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 16.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: lightColor2,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetConst.iconRating),
                    8.horizontalSpaceRadius,
                    Text('Penilaian', style: Get.textTheme.titleSmall),
                    const Spacer(),
                    PrimaryButton.compact(
                      text: 'Nilai Sekarang',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              27.verticalSpacingRadius,

              /// Info device
              Padding(
                padding: EdgeInsets.only(left: 20.r),
                child: Text(
                  'Info Lainnya',
                  style: Get.textTheme.titleMedium!.copyWith(color: blueColor),
                ),
              ),
              14.verticalSpacingRadius,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: lightColor2,
                ),
                child: Column(
                  children: [
                    TileOption(
                      title: 'Device Info',
                      message: 'Iphone 13',
                    ),
                    TileOption(
                      title: 'Version',
                      message: '1.3',
                    ),
                  ],
                ),
              ),
              32.verticalSpacingRadius,

              /// Logout
              Center(
                child: SizedBox(
                  width: 204,
                  child: PrimaryButton(
                    text: 'Log Out',
                    onPressed: () {},
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
