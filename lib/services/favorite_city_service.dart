import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite_city.dart';

class FavoriteCityService {
  static const String storageKey = 'favorite_cities';

  // Récupération des villes favorites depuis le téléphone
  Future<List<FavoriteCity>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(storageKey);

    if (savedList == null || savedList.isEmpty) {
      return [];
    }

    List<FavoriteCity> result = [];
    for (String item in savedList) {
      final decoded = jsonDecode(item);
      final city = FavoriteCity.fromMap(decoded);
      result.add(city);
    }

    return result;
  }

  // J’ajoute une ville si elle n’est pas déjà dans la liste
  Future<void> addFavorite(FavoriteCity city) async {
    final prefs = await SharedPreferences.getInstance();
    List<FavoriteCity> current = await getFavorites();

    bool alreadyExists = false;
    for (var c in current) {
      if (c.name.toLowerCase() == city.name.toLowerCase()) {
        alreadyExists = true;
        break;
      }
    }

    if (!alreadyExists) {
      current.add(city);
      List<String> toSave = [];

      for (var c in current) {
        final jsonStr = jsonEncode(c.toMap());
        toSave.add(jsonStr);
      }

      await prefs.setStringList(storageKey, toSave);
    }
  }

  // Suppression d’une ville favorite (comparaison complète)
  Future<void> removeFavorite(FavoriteCity city) async {
    final prefs = await SharedPreferences.getInstance();
    List<FavoriteCity> current = await getFavorites();

    current.removeWhere(
      (c) =>
          c.name == city.name &&
          c.latitude == city.latitude &&
          c.longitude == city.longitude,
    );

    List<String> updated = [];
    for (var c in current) {
      final str = jsonEncode(c.toMap());
      updated.add(str);
    }

    await prefs.setStringList(storageKey, updated);
  }
}
