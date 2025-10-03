import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nawy_search/features/explore/views/widgets/selected_filters_bar.dart';
import 'package:nawy_search/features/favorites/view_models/favorites_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/property_card.dart';
import '../view_models/search_view_model.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);
    final favViewModel = Provider.of<FavoritesViewModel>(context);
    final properties = viewModel.properties;
    final numberFormat = NumberFormat.decimalPattern();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: secondScreenBackgroundColor,
        appBar: AppBar(
          shadowColor: blackColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: [
                SelectedFiltersBar(),
                const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicatorColor: primaryColor,
                  indicatorWeight: 2,
                  labelColor: primaryColor,
                  unselectedLabelColor: lightTextColor,
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.25,
                  ),
                  tabs: [
                    Tab(text: 'PROPERTIES'),
                    Tab(text: 'COMPOUNDS'),
                  ],
                ),
              ],
            ),
          ),
          elevation: 2,
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
          backgroundColor: whiteColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Results',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: darkTextColor,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.go('/explore');
                    },
                    child: Icon(Icons.filter_alt, color: lightTextColor),
                  ),
                  SizedBox(width: 24),
                  Icon(Icons.sort, color: lightTextColor),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Properties
            viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Visibility(
                    visible: properties.isNotEmpty,
                    replacement: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (viewModel.error == null) ...[
                            const Text(
                              "No Results Found!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0179CB),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Please Change Your Filters",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0179CB),
                              ),
                            ),
                          ],
                          if (viewModel.error != null) ...[
                            const Text(
                              "An Error Has Occurred",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0179CB),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: properties.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return CustomText(
                            text: "${properties.length} results",
                            fontSize: 14,
                            marginTop: 15,
                            marginLeft: 24,
                          );
                        }
                        final property = properties[index - 1];
                        return PropertyCard(
                          property: property,
                          onTap: () {
                            favViewModel.toggleFavorite(property);
                          },
                        );
                      },
                    ),
                  ),

            // Tab 2: Compounds (Coming Soon)
            const Center(
              child: Text(
                "Compounds - Coming Soon",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0179CB),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
