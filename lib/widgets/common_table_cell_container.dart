import 'package:flutter/material.dart';

class CommonTableCellContainer extends StatelessWidget {
  final int flex;
  final Widget child;

  const CommonTableCellContainer(
      {super.key, required this.flex, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: child,
    );
  }
}
