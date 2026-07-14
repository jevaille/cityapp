import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {

  const StatusChip({
    super.key,
    required this.label,
    required this.color,
    this.isSmall = false,
  });
  final String label;
  final Color color;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 12,
        vertical: isSmall ? 4 : 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color.withValues(alpha: 0.1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isSmall ? 11 : 14,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}