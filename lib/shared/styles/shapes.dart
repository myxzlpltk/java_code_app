import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShape {
  CustomShape._();

  static ShapeBorder topRoundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
  );
}
