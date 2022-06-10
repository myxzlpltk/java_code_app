import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/profile/controllers/profile_controller.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/shared/widgets/tile_option.dart';
import 'package:java_code_app/utils/extensions/string_extension.dart';

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
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Stack(
                    children: [
                      Obx(
                        () => Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              ProfileController.to.user.value.foto != null,
                          widgetBuilder: (context) => Image.network(
                            ProfileController.to.user.value.foto!,
                            width: 170.r,
                            height: 170.r,
                            fit: BoxFit.cover,
                          ),
                          fallbackBuilder: (context) => Image.asset(
                            AssetConst.bgProfile,
                            width: 170.r,
                            height: 170.r,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Material(
                          color: AppColor.blueColor,
                          child: InkWell(
                            onTap: ProfileController.to.openUpdatePhotoDialog,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                              child: Text(
                                'Change'.tr,
                                style: Get.textTheme.labelMedium!
                                    .copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalSpacingRadius,

              /// Verifikasi KTP
              Obx(
                () => Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      ProfileController.to.user.value.ktp != null,
                  widgetBuilder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: AppColor.greenColor, size: 20.r),
                      8.horizontalSpaceRadius,
                      Text(
                        'You have verified your ID card'.tr,
                        style: Get.textTheme.labelMedium!
                            .copyWith(color: AppColor.blueColor),
                      ),
                    ],
                  ),
                  fallbackBuilder: (context) => Center(
                    child: InkWell(
                      onTap: ProfileController.to.openVerifyIDDialog,
                      borderRadius: BorderRadius.circular(5.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5.r,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AssetConst.iconKtp,
                              width: 18.r,
                              height: 18.r,
                              color: AppColor.blueColor,
                            ),
                            8.horizontalSpaceRadius,
                            Text(
                              'Verify your ID card now!'.tr,
                              style: Get.textTheme.labelMedium!
                                  .copyWith(color: AppColor.blueColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              20.verticalSpacingRadius,

              /// Info akun
              Padding(
                padding: EdgeInsets.only(left: 20.r),
                child: Text(
                  'Account info'.tr,
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: AppColor.blueColor),
                ),
              ),
              14.verticalSpacingRadius,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: AppColor.lightColor2,
                ),
                child: Column(
                  children: [
                    Obx(
                      () => TileOption(
                        title: 'Name'.tr,
                        message: ProfileController.to.user.value.nama,
                        onTap: ProfileController.to.openUpdateNameDialog,
                      ),
                    ),
                    Obx(
                      () => TileOption(
                        title: 'Birth date'.tr,
                        message:
                            ProfileController.to.user.value.tgl_lahir != null
                                ? DateFormat('dd/MM/yyyy').format(
                                    ProfileController.to.user.value.tgl_lahir!)
                                : '-',
                        onTap: ProfileController.to.openUpdateBirthDateDialog,
                      ),
                    ),
                    Obx(
                      () => TileOption(
                        title: 'Phone number'.tr,
                        message: ProfileController.to.user.value.telepon ?? '-',
                        onTap: ProfileController.to.openUpdatePhoneDialog,
                      ),
                    ),
                    Obx(
                      () => TileOption(
                        title: 'Email'.tr,
                        message: ProfileController.to.user.value.email,
                        onTap: ProfileController.to.openUpdateEmailDialog,
                      ),
                    ),
                    Obx(
                      () => TileOption(
                        title: 'Change PIN'.tr,
                        message:
                            ProfileController.to.user.value.pin.toObscure(),
                        onTap: ProfileController.to.openUpdatePINDialog,
                      ),
                    ),
                    Obx(
                      () => TileOption(
                        title: 'Change language'.tr,
                        message: ProfileController.to.currentLanguage.value,
                        onTap: ProfileController.to.openLanguageDialog,
                      ),
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
                  color: AppColor.lightColor2,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetConst.iconReview),
                    8.horizontalSpaceRadius,
                    Text('Review'.tr, style: Get.textTheme.titleSmall),
                    const Spacer(),
                    PrimaryButton.compact(
                      text: 'Review now'.tr,
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
                  'More info'.tr,
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: AppColor.blueColor),
                ),
              ),
              14.verticalSpacingRadius,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: AppColor.lightColor2,
                ),
                child: Column(
                  children: [
                    Obx(
                      () => TileOption(
                        title: 'Device info'.tr,
                        message: ProfileController.to.deviceInfo.value,
                      ),
                    ),
                    TileOption(
                      title: 'Version'.tr,
                      message: AppConst.appVersion,
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
                    text: 'Log out'.tr,
                    onPressed: ProfileController.to.logout,
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
