import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CurrentWeatherCard extends StatelessWidget {
  final String cityName;
  final Map<String, String> weather;
  final VoidCallback? onRefreshLocation; // pour rafraichir la psoition
  final bool isLoading;

  const CurrentWeatherCard({
    super.key,
    required this.cityName,
    required this.weather,
    this.onRefreshLocation,
    this.isLoading = false,
  });

  // je crée une fonction pour mettre la première lettre en majuscule car cela netais pas esthetique
  String _capitalize(String value) {
    if (value.isEmpty) return '';
    return value[0].toUpperCase() + value.substring(1);
  }

  // JE vérifie si l’icône météo représente du soleil
  bool _isSunny(String? icon) {
    if (icon == null) return false;
    return icon == "☀️" || icon.toLowerCase().contains("sun");
  }

  // JE vérifie si l’icône météo représente des nuages
  bool _isCloudy(String? icon) {
    if (icon == null) return false;
    return icon == "☁️" || icon.toLowerCase().contains("cloud");
  }

  @override
  Widget build(BuildContext context) {
    final icon = weather["icon"];

    return Card(
      elevation: 3,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ), // j'adore le border radius
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        ) // chargement lors de l'actualiation de la position
                      : _isSunny(icon) // si cest soleil anim soleil
                      ? Lottie.asset("assets/sun2.json", repeat: true)
                      : _isCloudy(icon)
                      ? Lottie.asset("assets/complete_cloud.json", repeat: true)
                      : Center(
                          child: Text(
                            icon ?? "❓",
                            style: const TextStyle(fontSize: 36),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: isLoading
                    ? const [
                        Text(
                          "Chargement météo...",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    : [
                        // le nom de la ville
                        Text(
                          _capitalize(cityName),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // la temperature recuperer
                        Text(
                          weather["temp"] ?? "--",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Ressentie : ${weather["feels_like"] ?? "--"}",
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Humidité : ${weather["humidity"] ?? "--"}",
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
              ),
            ),

            // le bouton pour rafraichir la position
            if (onRefreshLocation != null)
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: onRefreshLocation,
                  icon: const Icon(Icons.my_location),
                  tooltip: "Actualiser avec ma position",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
