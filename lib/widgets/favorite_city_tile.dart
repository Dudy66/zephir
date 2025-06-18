import 'package:flutter/material.dart';
import 'package:zephir/models/favorite_city.dart';

// creation du widget
class FavoriteCityTile extends StatelessWidget {
  final FavoriteCity city;
  final VoidCallback onDelete;
  final VoidCallback onSelect;

  const FavoriteCityTile({
    super.key,
    required this.city,
    required this.onDelete,
    required this.onSelect,
  });

  // les icones afin de facilite la perception des favoris
  Icon _getIconForType(String type) {
    switch (type) {
      case 'Maison':
        return const Icon(Icons.home, color: Colors.blue);
      case 'Vacances':
        return const Icon(Icons.beach_access, color: Colors.orange);
      case 'Autre':
        return const Icon(Icons.location_city, color: Colors.grey);
      default:
        return const Icon(Icons.place, color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: onSelect,
        leading: _getIconForType(city.type),
        title: Text(
          _capitalize(city.name),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete, // quand je clique sa delete
        ),
      ),
    );
  }

  // toujours pour ma majuscule
  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
