import 'package:demo/app/app_dimensions.dart';
import 'package:flutter/material.dart';

import '../app/app_font_weight.dart';
import 'common_text.dart';

// class CommonDropdown extends StatefulWidget {
//   final List<String> items;
//   final String? initialValue;
//   final String? hint;
//   final String? labelText; // New label text
//   final Function(String)? onChanged;
//
//   const CommonDropdown({
//     super.key,
//     required this.items,
//     this.initialValue,
//     this.hint,
//     this.labelText, // Accepting labelText
//     this.onChanged,
//   });
//
//   @override
//   State<CommonDropdown> createState() => _CommonDropdownState();
// }
//
// class _CommonDropdownState extends State<CommonDropdown> {
//   String? selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedValue =
//         widget.initialValue != null && widget.initialValue!.isNotEmpty
//             ? widget.initialValue
//             : null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start, // Align label properly
//       children: [
//         if (widget.labelText != null) // Only show label if provided
//           CommonText(
//             text: widget.labelText!,
//             fontWeight: AppFontWeight.w400,
//             fontSize: 12,
//             color: AppColors.colorDarkBlue,
//           ),
//         Container(
//           height: 45,
//           decoration: const BoxDecoration(
//             //color: Colors.white,
//             border: Border(
//               bottom: BorderSide(width: 1.0, color: AppColors.colorDarkGray),
//             ),
//           ),
//           child: DropdownButton<String>(
//             value: selectedValue,
//             isExpanded: true,
//             icon: const Icon(Icons.keyboard_arrow_down,
//                 color: AppColors.colorDarkGray),
//             underline: const SizedBox(),
//             hint: selectedValue == null
//                 ? CommonText(
//                     text: widget.hint ?? '',
//                     fontWeight: AppFontWeight.w400,
//                     fontSize: 14,
//                     color: AppColors.colorDarkBlue,
//                   )
//                 : null,
//             items: widget.items.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: CommonText(
//                   text: value,
//                   fontWeight: AppFontWeight.w400,
//                   fontSize: 16,
//                   color: AppColors.colorDarkBlue,
//                 ),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 selectedValue = newValue;
//               });
//               if (newValue != null && widget.onChanged != null) {
//                 widget.onChanged!(newValue);
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class CommonDropdown extends StatelessWidget {
  final List<String> items;
  final String? initialValue;
  final String? hint;
  final String? labelText;
  final Function(String)? onChanged;

  const CommonDropdown({
    super.key,
    required this.items,
    required this.initialValue,
    this.hint,
    this.labelText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          CommonText(
            text: labelText!,
            fontWeight: AppFontWeight.w400,
            fontSize: AppDimensions.fontSizeRegular,
          ),
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          child: DropdownButton<String>(
            //value: initialValue,
            value: items.contains(initialValue) ? initialValue : null,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            underline: const SizedBox(),
            hint:
                initialValue == null
                    ? CommonText(
                      text: hint ?? '',
                      fontWeight: AppFontWeight.w400,
                      fontSize: AppDimensions.fontSizeRegular,
                    )
                    : null,
            items:
                items.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: CommonText(
                      text: val,
                      fontWeight: AppFontWeight.w400,
                      fontSize: AppDimensions.fontSizeRegular,
                    ),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null && onChanged != null) {
                onChanged!(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
}
