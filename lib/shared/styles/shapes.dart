import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom Shape untuk [Container]
class CustomShape {
  /// Memastikan class ini tidak bisa diinstansiasi
  CustomShape._();

  /// [Container] dengan [borderRadius] yang berbentuk rounded di atas
  static ShapeBorder topRoundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
  );

  /// [Container] dengan [borderRadius] yang berbentuk rounded di bawah
  static ShapeBorder bottomRoundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
  );
}
