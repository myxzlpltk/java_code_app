import 'package:get/get.dart';

String scoreToString(double score) {
  if (score >= 5) {
    return 'Perfect'.tr;
  } else if (score >= 4) {
    return 'Almost Perfect'.tr;
  } else if (score >= 3) {
    return 'Good'.tr;
  } else if (score >= 2) {
    return 'Bad'.tr;
  } else if (score >= 1) {
    return 'Very Bad'.tr;
  } else {
    return 'No Rating'.tr;
  }
}
