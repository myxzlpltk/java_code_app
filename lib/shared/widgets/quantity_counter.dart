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
        Visibility(
          visible: quantity > 0,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              onTap: onDecrement,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: blueColor, width: 2),
                ),
                child: const Icon(Icons.remove, size: 16, color: blueColor),
              ),
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(minWidth: 30.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            quantity.toString(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: onIncrement,
            child: Ink(
              padding: const EdgeInsets.all(2),
              color: blueColor,
              child: const Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
