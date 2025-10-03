import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/global_functions.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../view_models/search_view_model.dart';

class PriceRangeDropdown extends StatelessWidget {
  const PriceRangeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);
    final minPrices = viewModel.filterOptions?.minPriceList ?? [];
    final maxPrices = viewModel.filterOptions?.maxPriceList ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: 'Price', fontSize: 16, marginTop: 25),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                isExpanded: true,
                value: viewModel.selectedMinPrice,
                decoration: const InputDecoration(
                  labelText: 'Min Price',
                  labelStyle: TextStyle(fontSize: 12),
                ),
                items: minPrices.map((price) {
                  return DropdownMenuItem<int>(
                    value: price,
                    child: Text(formatPrice(price)),
                  );
                }).toList(),
                onChanged: (value) {
                  viewModel.selectedMinPrice = value;
                  viewModel.notifyListeners();
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<int>(
                isExpanded: true,
                value: viewModel.selectedMaxPrice,
                decoration: const InputDecoration(
                  labelText: 'Max Price',
                  labelStyle: TextStyle(fontSize: 12),
                ),
                items: maxPrices.map((price) {
                  return DropdownMenuItem<int>(
                    value: price,
                    child: Text(formatPrice(price)),
                  );
                }).toList(),
                onChanged: (value) {
                  viewModel.selectedMaxPrice = value;
                  viewModel.notifyListeners();
                },
              ),
            ),
          ],
        ),
        if (viewModel.priceRangeError != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              viewModel.priceRangeError!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),
      ],
    );
  }
}
