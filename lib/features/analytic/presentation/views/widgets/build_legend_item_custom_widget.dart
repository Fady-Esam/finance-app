import 'package:flutter/material.dart';

class BuildLegendItemCustomWidget extends StatelessWidget {
  const BuildLegendItemCustomWidget({
    super.key,
    required this.color,
    required this.label,
  });
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
