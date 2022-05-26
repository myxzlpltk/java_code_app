import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.black.withOpacity(0.25))),
        SizedBox(width: 15.w),
        Text(text, style: Theme.of(context).textTheme.bodyText2),
        SizedBox(width: 15.w),
        Expanded(child: Divider(color: Colors.black.withOpacity(0.25))),
      ],
    );
  }
}
