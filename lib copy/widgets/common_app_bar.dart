import 'package:flutter/material.dart';

import '../app/app_font_weight.dart';
import 'common_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CommonAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        size: 24,
        color: isDark ? Colors.white : Colors.black,
      ),
      backgroundColor: theme.colorScheme.primaryContainer,
      title: CommonText(
        text: title,
        fontSize: 20,
        fontWeight: AppFontWeight.w600,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
