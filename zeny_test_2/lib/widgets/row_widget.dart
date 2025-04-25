import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFD0DEFF), width: 0.5), // Add bottom border
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }
}