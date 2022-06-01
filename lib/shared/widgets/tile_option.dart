import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class TileOption extends StatelessWidget {
  final String? icon;
  final String title;
  final String? subtitle;
  final String message;
  final String? messageSubtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? messageStyle;
  final TextStyle? messageSubtitleStyle;
  final void Function()? onTap;
  final Color color;
  final double? iconSize;

  const TileOption({
    Key? key,
    this.icon,
    required this.title,
    this.subtitle,
    required this.message,
    this.messageSubtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.messageStyle,
    this.messageSubtitleStyle,
    this.onTap,
    this.color = Colors.white,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
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
                  constraints: BoxConstraints(minWidth: (iconSize ?? 20.r) * 2),
                  child: SvgPicture.asset(
                    icon!,
                    height: iconSize ?? 20.r,
                    width: iconSize ?? 20.r,
                  ),
                ),
              ),
              Text(
                title,
                style: titleStyle ?? Theme.of(context).textTheme.titleSmall,
              ),
              if (subtitle != null)
                Text(
                  ' ${subtitle!}',
                  style: subtitleStyle ?? Theme.of(context).textTheme.bodyLarge,
                ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      style:
                          messageStyle ?? Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (messageSubtitle != null)
                      Text(
                        messageSubtitle!,
                        textAlign: TextAlign.end,
                        style: messageSubtitleStyle ??
                            Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(height: 1),
                      ),
                  ],
                ),
              ),
              if (onTap == null)
                SizedBox(width: 5.w)
              else
                const Icon(Icons.chevron_right, color: greyColor),
            ],
          ),
        ),
      ),
    );
  }
}
