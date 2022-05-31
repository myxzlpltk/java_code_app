import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class Tile extends StatelessWidget {
  final String? icon;
  final String title;
  final String message;
  final TextStyle? messageStyle;
  final void Function()? onTap;

  const Tile({
    Key? key,
    this.icon,
    required this.title,
    this.messageStyle,
    required this.message,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Conditional.single(
                context: context,
                conditionBuilder: (context) => icon == null,
                widgetBuilder: (context) => SizedBox(width: 5.w),
                fallbackBuilder: (context) => Container(
                  constraints: BoxConstraints(minWidth: 30.w),
                  child: SvgPicture.asset(icon!, height: 17.h),
                ),
              ),
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  message,
                  style: messageStyle ?? Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10.w),
              const Icon(Icons.chevron_right, color: greyColor),
            ],
          ),
        ),
      ),
    );
  }
}
