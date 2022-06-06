import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/modules/features/menu/view/components/holder_bottom_sheet.dart';
import 'package:java_code_app/modules/features/profile/view/components/locale_card.dart';
import 'package:java_code_app/utils/extensions/list_extensions.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  Rx<Locale> selectedLocale = Rx<Locale>(Localization.currentLocale);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HolderBottomSheet(),
          13.verticalSpacingRadius,
          Text('Change language'.tr, style: Get.textTheme.headlineSmall),
          16.verticalSpacingRadius,
          Wrap(
            spacing: 12.r,
            runSpacing: 12.r,
            children: Localization.langs
                .mapIndexed<LocaleCard>(
                  (lang, i) => LocaleCard(
                      isSelected:
                          selectedLocale.value == Localization.locales[i],
                      flag: Localization.flags[i],
                      language: Localization.langs[i],
                      onTap: () {
                        selectedLocale.value = Localization.locales[i];
                        Localization.changeLocale(Localization.langs[i]);
                        LocalDBServices.setLanguage(Localization.langs[i]);
                        Get.back();
                      }),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
