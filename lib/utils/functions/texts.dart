import 'package:get/get.dart';

String scoreToString(int score) {
  switch (score) {
    case 1:
      return 'Very Bad'.tr;
    case 2:
      return 'Bad'.tr;
    case 3:
      return 'Good'.tr;
    case 4:
      return 'Almost Perfect'.tr;
    case 5:
      return 'Perfect'.tr;
    default:
      return '-';
  }
}
