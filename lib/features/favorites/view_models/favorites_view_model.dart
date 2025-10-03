import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../explore/models/property.dart';

class FavoritesViewModel extends ChangeNotifier {
  List<Property> _favoriteProperties = [];

  List<Property> get favoriteProperties => _favoriteProperties;

  Future<void> loadFavoritesFromPrefs(List<Property> currentProperties) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('favorite_ids') ?? [];

    _favoriteProperties.clear();

    for (final property in currentProperties) {
      if (ids.contains(property.id.toString())) {
        property.isFavorite = true;
        _favoriteProperties.add(property);
      }
    }

    notifyListeners();
  }

  void toggleFavorite(Property property) async {
    property.isFavorite = !property.isFavorite;

    if (property.isFavorite) {
      _favoriteProperties.add(property);
    } else {
      _favoriteProperties.removeWhere((p) => p.id == property.id);
    }

    await _saveFavoritesToPrefs();
    notifyListeners();
  }

  bool isFavorite(Property property) {
    return _favoriteProperties.any((p) => p.id == property.id);
  }

  Future<void> _saveFavoritesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = _favoriteProperties.map((p) => p.id.toString()).toList();
    await prefs.setStringList('favorite_ids', ids);
  }

  Set<int> get favoriteIds => _favoriteProperties.map((p) => p.id).toSet();
}
