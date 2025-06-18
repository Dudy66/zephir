// Comme en Swift, on déclare ici le modèle de données sur lequel l'objet va se baser
class FavoriteCity {
  final String name;
  final String type;
  final double latitude;
  final double longitude;

  FavoriteCity({
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory FavoriteCity.fromMap(Map<String, dynamic> map) {
    return FavoriteCity(
      name: map['name'],
      type: map['type'] ?? 'autre',
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
