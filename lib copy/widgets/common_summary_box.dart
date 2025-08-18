import 'package:demo/app/app_font_weight.dart';
import 'package:demo/widgets/common_text.dart';
import 'package:flutter/material.dart';

class CommonSummaryBox extends StatelessWidget {
  final String title;
  final String value;
  final bool isHighlighted;

  const CommonSummaryBox({
    super.key,
    required this.title,
    required this.value,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlighted
            ? colorScheme.primary.withValues(alpha: 0.1)
            : theme.cardColor,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: title,
            fontSize: 12,
            fontWeight: AppFontWeight.w600,
            color: theme.textTheme.bodySmall?.color,
          ),
          const SizedBox(height: 4),
          CommonText(
            text: value,
            fontSize: 16,
            fontWeight: AppFontWeight.w700,
            color: isHighlighted
                ? colorScheme.primary
                : theme.textTheme.bodyLarge?.color,
          ),
        ],
      ),
    );
  }
}
