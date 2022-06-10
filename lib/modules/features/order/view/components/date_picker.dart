// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTimeRange) onChanged;
  final DateTimeRange selectedDate;

  const DatePicker({
    Key? key,
    required this.onChanged,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late Rx<DateTime> startDate;
  late Rx<DateTime> endDate;

  @override
  void initState() {
    super.initState();

    startDate = Rx<DateTime>(widget.selectedDate.start);
    endDate = Rx<DateTime>(widget.selectedDate.end);
  }

  void _openDateRangePicker(BuildContext context) async {
    final dateTimeRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: startDate.value,
        end: endDate.value,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      locale: Localization.currentLocale,
    );

    if (dateTimeRange != null) {
      startDate.value = dateTimeRange.start;
      endDate.value = dateTimeRange.end;
      widget.onChanged(dateTimeRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDateRangePicker(context),
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.fromLTRB(12.r, 9.r, 12.r, 9.r),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: BorderSide(color: AppColor.blueColor, width: 1.r),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Obx(
                () => Text(
                  '${DateFormat('dd/MM/yy').format(startDate.value)} - ${DateFormat('dd/MM/yy').format(endDate.value)}',
                  style: Get.textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            5.horizontalSpaceRadius,
            Icon(Icons.date_range, size: 24.r, color: AppColor.blueColor),
          ],
        ),
      ),
    );
  }
}
