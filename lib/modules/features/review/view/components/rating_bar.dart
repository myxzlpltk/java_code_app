import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class RatingBar extends StatelessWidget {
  final int rating;
  final double spacing;
  final double size;
  final void Function(int)? onRatingChanged;

  const RatingBar({
    Key? key,
    required this.rating,
    required this.spacing,
    required this.size,
    this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            if (onRatingChanged != null) {
              onRatingChanged!(index + 1);
            }
          },
          child: Container(
            width: size,
            height: size,
            margin: EdgeInsets.only(
              left: index > 0 ? spacing / 2 : 0,
              right: index < 4 ? spacing / 2 : 0,
            ),
            child: Conditional.single(
              context: context,
              conditionBuilder: (context) => index < rating,
              widgetBuilder: (context) => ShaderMask(
                child: SvgPicture.asset(
                  AssetConst.iconStar,
                  width: size,
                  height: size,
                ),
                shaderCallback: (rect) {
                  return AppColor.orangeGradient.createShader(rect);
                },
              ),
              fallbackBuilder: (context) => SvgPicture.asset(
                AssetConst.iconStarEmpty,
                width: size,
                height: size,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
