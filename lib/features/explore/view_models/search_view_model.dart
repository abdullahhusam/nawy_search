import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nawy_search/core/constants/global_functions.dart';
import '../../../core/services/app_apis.dart';
import '../../favorites/view_models/favorites_view_model.dart';
import '../models/area.dart';
import '../models/compound.dart';
import '../models/filter_options.dart';
import '../models/property.dart';

class SearchViewModel extends ChangeNotifier {
  final FavoritesViewModel favoritesVM;

  SearchViewModel(this.favoritesVM);

  List<Area> areas = [];
  List<Compound> compounds = [];
  FilterOptions? filterOptions;

  String? priceRangeError;
  bool _initialized = false;
  int? selectedAreaId;
  int? selectedCompoundId;
  int? selectedMinBedrooms;
  int? selectedMaxBedrooms;
  int? selectedMinPrice;
  int? selectedMaxPrice;

  int get minBedrooms => filterOptions?.minBedrooms ?? 1;
  int get maxBedrooms => filterOptions?.maxBedrooms ?? 7;

  Timer? _debounce;

  List<Property> properties = [];
  int totalProperties = 0;

  Area? selectedArea;
  Compound? selectedCompound;
  List<dynamic> suggestions = [];

  bool isLoading = false;
  String? error;

  Future<void> loadInitialData() async {
    if (_initialized) {
      return;
    }
    try {
      _initialized = true;
      isLoading = true;
      notifyListeners();
      final fetchedAreas = await AppApis.fetchAreas();
      final fetchedCompounds = await AppApis.fetchCompounds();
      final fetchedFilterOptions = await AppApis.fetchFilterOptions();
      final response = await AppApis.fetchProperties({});
      areas = fetchedAreas;
      compounds = fetchedCompounds;
      filterOptions = fetchedFilterOptions;
      properties = response.values;
      await favoritesVM.loadFavoritesFromPrefs(properties);
      _syncFavorites();
    } catch (e) {
      error = 'Failed to load initial data';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _syncFavorites() {
    final favIds = favoritesVM.favoriteIds;
    for (var property in properties) {
      property.isFavorite = favIds.contains(property.id);
    }
  }

  void handleSearchInput(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      updateSuggestions(query);
    });
  }

  void updateSuggestions(String query) {
    final lower = query.toLowerCase().trim();
    if (lower.isEmpty) {
      suggestions = [];
    } else {
      final areaMatches = areas
          .where((area) => area.name.toLowerCase().startsWith(lower))
          .toList();

      final compoundMatches = compounds
          .where((compound) => compound.name.toLowerCase().startsWith(lower))
          .toList();

      suggestions = [...areaMatches, ...compoundMatches];
    }
    notifyListeners();
  }

  void selectSuggestion(dynamic suggestion) {
    if (suggestion is Area) {
      selectedArea = suggestion;
      selectedAreaId = suggestion.id;
    } else if (suggestion is Compound) {
      selectedCompound = suggestion;
      selectedCompoundId = suggestion.id;
    }
    suggestions = [];
    notifyListeners();
  }

  Future<void> searchProperties() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();
      final filters = <String, dynamic>{};
      if (selectedAreaId != null) filters['area_id'] = selectedAreaId;
      if (selectedCompoundId != null)
        filters['compound_id'] = selectedCompoundId;
      if (selectedMinBedrooms != null)
        filters['min_bedrooms'] = selectedMinBedrooms;
      if (selectedMaxBedrooms != null)
        filters['max_bedrooms'] = selectedMaxBedrooms;
      if (selectedMinPrice != null) filters['min_price'] = selectedMinPrice;
      if (selectedMaxPrice != null) filters['max_price'] = selectedMaxPrice;

      final response = await AppApis.fetchProperties(filters);

      properties = response.values.where((p) {
        if (selectedAreaId != null && p.areaId != selectedAreaId) return false;
        if (selectedCompoundId != null && p.compoundId != selectedCompoundId)
          return false;
        if (selectedMinBedrooms != null &&
            (p.numberOfBedrooms ?? 0) < selectedMinBedrooms!)
          return false;
        if (selectedMaxBedrooms != null &&
            (p.numberOfBedrooms ?? 0) > selectedMaxBedrooms!)
          return false;
        if (selectedMinPrice != null && (p.maxPrice ?? 0) < selectedMinPrice!)
          return false;
        if (selectedMaxPrice != null && (p.maxPrice ?? 0) > selectedMaxPrice!)
          return false;
        return true;
      }).toList();

      totalProperties = properties.length;
      _syncFavorites();
    } catch (e) {
      error = 'Failed to fetch properties';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool validateFilters() {
    priceRangeError = null;
    if (selectedMinPrice != null &&
        selectedMaxPrice != null &&
        selectedMinPrice! >= selectedMaxPrice!) {
      priceRangeError =
          'Minimum price can’t be greater than or equals maximum price';
      notifyListeners();
      return false;
    }
    return true;
  }

  void resetFilters() {
    selectedArea = null;
    selectedCompound = null;
    selectedAreaId = null;
    selectedCompoundId = null;
    selectedMinBedrooms = null;
    selectedMaxBedrooms = null;
    selectedMinPrice = null;
    selectedMaxPrice = null;
    notifyListeners();
  }

  List<String> getSelectedFilters() {
    List<String> filters = [];

    if (selectedArea != null) filters.add(selectedArea!.name);
    if (selectedCompound != null) filters.add(selectedCompound!.name);
    if (selectedMinBedrooms != null && selectedMaxBedrooms != null)
      filters.add("$selectedMinBedrooms ~ $selectedMaxBedrooms Rooms");
    if (selectedMinPrice != null)
      filters.add('Min Price: ${formatPrice(selectedMinPrice!)}');
    if (selectedMaxPrice != null)
      filters.add('Max Price: ${formatPrice(selectedMaxPrice!)}');

    return filters;
  }
}
