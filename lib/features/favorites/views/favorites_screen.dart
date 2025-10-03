import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nawy_search/features/favorites/view_models/favorites_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/property_card.dart';
import '../../explore/view_models/search_view_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FavoritesViewModel>(context);
    final searchViewModel = Provider.of<SearchViewModel>(context);

    final favorites = viewModel.favoriteProperties;

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: searchViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Visibility(
              visible: favorites.isNotEmpty,
              replacement: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No Favorites Yet!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0179CB),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Start adding properties you like",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0179CB),
                      ),
                    ),
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final property = favorites[index];

                  return PropertyCard(
                    property: property,
                    onTap: () {
                      viewModel.toggleFavorite(property);
                    },
                  );
                },
              ),
            ),
    );
  }
}
