import 'package:demo_project/app/app_colors.dart';
import 'package:demo_project/app/app_font_weight.dart';
import 'package:demo_project/app/app_images.dart';
import 'package:demo_project/widgets/common_app_image.dart';
import 'package:demo_project/widgets/common_text.dart';
import 'package:flutter/material.dart';

class CommonExpansionTile extends StatefulWidget {
  final String title;
  final String leadingIcon;
  final List<Widget> children;

  const CommonExpansionTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.children,
  });

  @override
  State<CommonExpansionTile> createState() => _CommonExpansionTileState();
}

class _CommonExpansionTileState extends State<CommonExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5));
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -2),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: CommonAppImage(
            imagePath: widget.leadingIcon,
            width: 24,
            height: 24,
            color: AppColors.colorDarkGray,
          ),
          title: CommonText(
            text: widget.title,
            color: AppColors.colorDarkGray,
            fontWeight: AppFontWeight.w600,
          ),
          trailing: RotationTransition(
            turns: _iconTurns,
            child: const CommonAppImage(
              imagePath: AppImages.icDownArrowIcon,
              width: 24,
              height: 24,
              color: AppColors.colorDarkGray,
            ),
          ),
          onTap: _handleTap,
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(children: widget.children),
          crossFadeState:
              _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
