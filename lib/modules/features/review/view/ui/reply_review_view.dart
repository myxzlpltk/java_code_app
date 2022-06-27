import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/review/view/components/date_chat.dart';
import 'package:java_code_app/modules/features/review/view/components/left_chat.dart';
import 'package:java_code_app/modules/features/review/view/components/right_chat.dart';
import 'package:java_code_app/shared/styles/shapes.dart';

class ReplyReviewView extends StatelessWidget {
  const ReplyReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightColor3,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 30.r,
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
          onPressed: () => Get.back(closeOverlays: true),
        ),
        centerTitle: true,
        title: Text('Reply Review'.tr, style: Get.textTheme.titleMedium),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.fromLTRB(21.r, 16.r, 21.r, 96.r),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          image: const DecorationImage(
            image: AssetImage(AssetConst.bgPattern2),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 28.r, horizontal: 14.r),
          separatorBuilder: (context, index) => 28.verticalSpacingRadius,
          reverse: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            if (index == 9) {
              return DateChat(
                date: DateTime.now(),
              );
            } else if (index % 2 == 0) {
              return LeftChat(
                message: 'Mohon menjaga kebersihan, kemarin meja masih kotor',
                date: DateTime.now().subtract(Duration(minutes: index)),
              );
            } else {
              return RightChat(
                message:
                    'Mohon maaf atas masalah tsb, crew kami akan melakukan evaluasi kembali perihal kebersihan fasilitas cafe',
                date: DateTime.now().subtract(Duration(minutes: index)),
              );
            }
          },
        ),
      ),
      bottomSheet: Container(
        height: 80.r,
        padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 20.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 7.r,
              spreadRadius: -1.r,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    width: 0.5.r,
                    color: AppColor.darkColor2.withOpacity(0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: Get.textTheme.bodyMedium,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type a message...'.tr,
                          hintStyle: Get.textTheme.bodyMedium!.copyWith(
                            color: AppColor.lightColor3,
                          ),
                        ),
                      ),
                    ),
                    16.horizontalSpaceRadius,
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        customBorder: const CircleBorder(),
                        child: SvgPicture.asset(
                          AssetConst.iconAddImage,
                          height: 22.r,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.horizontalSpaceRadius,
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SvgPicture.asset(AssetConst.iconSend, height: 22.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
