import 'package:flutter/material.dart';
import 'package:zephir/models/favorite_city.dart';
import 'package:zephir/widgets/favorite_city_tile.dart';

// création de la card
class FavoriteCard extends StatelessWidget {
  final List<FavoriteCity> favorites; // liste des favoris
  final Function(FavoriteCity) onDelete;
  final Function(FavoriteCity) onSelect;
  final double? minHeight;

  const FavoriteCard({
    super.key,
    required this.favorites,
    required this.onDelete,
    required this.onSelect,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        height: minHeight ?? 260,
        width: double.infinity, // toute la largeur dispo
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // debut a gauche
          children: [
            Center(
              child: Text(
                "Favoris",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: favorites.isEmpty
                  ? const Center(
                      child: Text(
                        "Aucun favori pour l’instant.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          favorites.length, // boucle sur tous les favoris
                      itemBuilder: (context, index) {
                        final city = favorites[index];
                        return FavoriteCityTile(
                          city: city,
                          onDelete: () => onDelete(city),
                          onSelect: () => onSelect(city),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
