import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';

class AppDatePicker {
  static String currentYYYYMMDDDate1() {
    return _formatDate(DateTime.now());
  }

  static String last7DaysDate() {
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));
    return _formatDate(sevenDaysAgo);
  }

  static String last1MonthDate() {
    final DateTime now = DateTime.now();
    final DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
    return _formatDate(oneMonthAgo);
  }

  static String lastMonthStartDate() {
    final DateTime now = DateTime.now();
    final DateTime start = DateTime(now.year, now.month - 1);
    return _formatDate(start);
  }

  static String lastMonthEndDate() {
    final DateTime now = DateTime.now();
    final DateTime end = DateTime(now.year, now.month, 0);
    return _formatDate(end);
  }

  static String currentMonthStartDate() {
    final DateTime now = DateTime.now();
    return _formatDate(DateTime(now.year, now.month));
  }

  static String currentMonthEndDate() {
    final DateTime now = DateTime.now();
    final DateTime firstDayNextMonth =
        (now.month < 12)
            ? DateTime(now.year, now.month + 1)
            : DateTime(now.year + 1);
    final DateTime lastDayCurrentMonth = firstDayNextMonth.subtract(
      const Duration(days: 1),
    );
    return _formatDate(lastDayCurrentMonth);
  }

  static String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String currentDate() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String currentDate = dateFormat.format(DateTime.now());
    return currentDate;
  }

  static String currentYYYYMMDDDate() {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final String currentDate = dateFormat.format(DateTime.now());
    return currentDate;
  }

  static String currentYear() {
    final DateFormat yearFormat = DateFormat('yyyy');
    final String strYear = yearFormat.format(DateTime.now());
    return strYear;
  }

  static String currentMonth() {
    final DateFormat monthFormat = DateFormat('MM');
    final String strMonth = monthFormat.format(DateTime.now());
    return strMonth;
  }

  static String currentDay() {
    final DateFormat dayFormat = DateFormat('dd');
    final String strDay = dayFormat.format(DateTime.now());
    return strDay;
  }

  static String formatDate(DateTime dateTime) {
    //DateFormat dateFormat = DateFormat('yyyy/MM/dd');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String selected = dateFormat.format(dateTime);
    return selected;
  }

  static String dateMMMForm(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd/MMM/yyyy');
    return formatter.format(date);
  }

  static String convertDateTimeFormat(
    String inputDate,
    String inputDateFormat,
    String outputDateFormat,
  ) {
    final DateFormat inputParser = DateFormat(inputDateFormat);
    final DateFormat outputParser = DateFormat(outputDateFormat);
    final date = inputParser.parse(inputDate);
    final String outPutData = outputParser.format(date);
    return outPutData;
  }

  static String firstDayOfYear() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final DateTime firstDay = DateTime(DateTime.now().year);
    return dateFormat.format(firstDay);
  }

  static String lastDayOfYear() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final DateTime lastDay = DateTime(DateTime.now().year, 12, 31);
    return dateFormat.format(lastDay);
  }

  static String firstDayFinancialYear() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final DateTime now = DateTime.now();
    final int startYear = now.month < 4 ? now.year - 1 : now.year;
    final DateTime firstDay = DateTime(startYear, 4);
    return dateFormat.format(firstDay);
  }

  static String lastDayFinancialYear() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final DateTime now = DateTime.now();
    final int endYear = now.month < 4 ? now.year : now.year + 1;
    final DateTime lastDay = DateTime(endYear, 3, 31);
    return dateFormat.format(lastDay);
  }

  static void allDateEnable(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      //lastDate: DateTime(int.parse(currentYear()), 12, 31),
      lastDate: DateTime(int.parse(currentYear()) + 74, 12, 31),
      //firstDate: DateTime.now(),//Previous Date Disable
      //lastDate: DateTime.now(),//Future Date Disable
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      // helpText: "SELECT BOOKING DATE",
      // cancelText: "NOT NOW",
      // confirmText: "BOOK NOW",
      // fieldHintText: "DATE/MONTH/YEAR",
      // fieldLabelText: "BOOKING DATE",
      // errorFormatText: "Enter a Valid Date",
      // errorInvalidText: "Date Out of Range",
      // initialDatePickerMode: DatePickerMode.day,
    );

    if (selected != null) {
      controller.text = formatDate(selected);
    }
  }

  static void previousDateDisable(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      //lastDate: DateTime(int.parse(currentYear()), 12, 31),
      lastDate: DateTime(2100, 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (selected != null) {
      controller.text = formatDate(selected);
    }
  }

  static void futureDateDisable(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (selected != null) {
      controller.text = formatDate(selected);
    }
  }

  static Future<DateTime?> allDateEnable11(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime defaultDate = DateFormat(
      'dd/MM/yyyy',
    ).parse(firstDayFinancialYear());

    final DateTime initialDate =
        controller.text.isNotEmpty
            ? DateFormat('dd/MM/yyyy').parse(controller.text)
            : defaultDate;

    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;

    final ThemeData datePickerTheme =
        platformBrightness == Brightness.dark
            ? ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF9FC9FF),
                onPrimary: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.black,
            )
            : ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0xFF004881)),
              scaffoldBackgroundColor: Colors.white,
            );

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1999),
      lastDate: DateTime(int.parse(currentYear()) + 74, 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(data: datePickerTheme, child: child!);
      },
    );

    if (selected != null) {
      controller.text = formatDate(selected);
    }

    return selected;
  }

  static Future<DateTime?> allDateEnable1(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime defaultDate = DateFormat(
      'dd/MM/yyyy',
    ).parse(firstDayFinancialYear());

    final DateTime initialDate =
        controller.text.isNotEmpty
            ? DateFormat('dd/MM/yyyy').parse(controller.text)
            : defaultDate;

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1999),
      lastDate: DateTime(int.parse(currentYear()) + 74, 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.indigoSwatch,
            colorScheme: const ColorScheme.light(
              primary: AppColors.indigoSwatch,
            ),
            scaffoldBackgroundColor: AppColors.colorWhite,
          ),
          child: child!,
        );
      },
    );

    if (selected != null) {
      controller.text = formatDate(selected);
    }

    return selected;
  }

  static Future<DateTime?> previousDateDisable1(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime defaultDate = DateFormat(
      'dd/MM/yyyy',
    ).parse(firstDayFinancialYear());

    final DateTime initialDate =
        controller.text.isNotEmpty
            ? DateFormat('dd/MM/yyyy').parse(controller.text)
            : defaultDate;

    final DateTime? selected = await showDatePicker(
      context: context,
      //initialDate: DateTime.now(),
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100, 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.indigoSwatch,
            colorScheme: const ColorScheme.light(
              primary: AppColors.indigoSwatch,
            ),
            scaffoldBackgroundColor: AppColors.colorWhite,
          ),
          child: child!,
        );
      },
    );

    if (selected != null) {
      controller.text = formatDate(selected);
    }

    return selected;
  }

  static Future<DateTime?> futureDateDisable1(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime defaultDate = DateFormat(
      'dd/MM/yyyy',
    ).parse(firstDayFinancialYear());

    final DateTime initialDate =
        controller.text.isNotEmpty
            ? DateFormat('dd/MM/yyyy').parse(controller.text)
            : defaultDate;

    final DateTime? selected = await showDatePicker(
      context: context,
      //initialDate: DateTime.now(),
      initialDate: initialDate,
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
      // Prevents selecting future dates
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.indigoSwatch,
            colorScheme: const ColorScheme.light(
              primary: AppColors.indigoSwatch,
            ),
            scaffoldBackgroundColor: AppColors.colorWhite,
          ),
          child: child!,
        );
      },
    );

    if (selected != null) {
      controller.text = formatDate(selected);
    }

    return selected;
  }
}
