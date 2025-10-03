import 'package:flutter/material.dart';
import 'package:nawy_search/core/constants/colors.dart';

class SelectedFilterChip extends StatelessWidget {
  final String label;

  const SelectedFilterChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        padding: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        label: Text(
          label,
          style: const TextStyle(color: offWhiteColor, fontSize: 12),
        ),
        backgroundColor: primaryColor, // Primary blue
      ),
    );
  }
}
