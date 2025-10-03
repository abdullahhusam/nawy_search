import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nawy_search/core/constants/colors.dart';
import 'package:nawy_search/features/explore/views/widgets/area_compound_search_field.dart';

import 'package:provider/provider.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../view_models/search_view_model.dart';
import 'widgets/bedrooms_range_slider.dart';
import 'widgets/price_range_dropdown.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            if (context.canPop()) {
              context.pop(context);
            }
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: darkTextColor,
            size: 20,
          ),
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Search',
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: darkTextColor,
            ),
            InkWell(
              onTap: () {
                viewModel.resetFilters();
              },
              child: CustomText(
                text: 'Clear',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: darkTextColor,
                underline: true,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AreaCompoundSearchField(),
            const PriceRangeDropdown(),
            const BedroomsRangeSlider(),
            CustomButton(
              marginTop: 50,
              text: 'SHOW RESULTS',
              onPressed: () async {
                final viewModel = Provider.of<SearchViewModel>(
                  context,
                  listen: false,
                );

                final isValid = viewModel.validateFilters();
                if (!isValid) return;

                viewModel.searchProperties();

                context.push('/explore/results');
              },
            ),
          ],
        ),
      ),
    );
  }
}
