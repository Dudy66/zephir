import 'package:geolocator/geolocator.dart';

class WeatherGeolocService {
  // Demande la permission + retourne la position actuelle
  static Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Je verifie si le service est activé
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    // Sa verifie les permissions accordé
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    // si l'utilisateur clique sur jamais pour la localisation
    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    // Si tout est OK je récupère la position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
