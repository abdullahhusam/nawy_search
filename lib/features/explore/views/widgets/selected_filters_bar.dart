import 'package:flutter/material.dart';
import 'package:nawy_search/features/explore/views/widgets/selected_filter_chip.dart';
import 'package:provider/provider.dart';

import '../../view_models/search_view_model.dart';

class SelectedFiltersBar extends StatelessWidget {
  const SelectedFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SearchViewModel>(context); // listen: true by default
    final filters = vm.getSelectedFilters();

    if (filters.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return SelectedFilterChip(label: filters[index]);
        },
      ),
    );
  }
}
