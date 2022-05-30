import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class QuantityCounter extends StatelessWidget {
  final int quantity;
  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const QuantityCounter({
    Key? key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onDecrement,
          borderRadius: BorderRadius.circular(4),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: blueColor,
                width: 3,
              ),
            ),
            child: const Icon(Icons.remove, size: 20, color: blueColor),
          ),
        ),
        SizedBox(width: 10.w),
        Text(quantity.toString(), style: Theme.of(context).textTheme.subtitle1),
        SizedBox(width: 10.w),
        InkWell(
          onTap: onDecrement,
          borderRadius: BorderRadius.circular(4),
          child: Ink(
            decoration: BoxDecoration(
              color: blueColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.add, size: 24, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
