import 'package:flutter/material.dart';

// creation de la card
class WeatherDayCard extends StatelessWidget {
  final String dayLabel; // le nom du jour
  final List<Map<String, String>> hourlyData; // heure par heure
  final bool showHourDetails;

  const WeatherDayCard({
    super.key,
    required this.dayLabel,
    required this.hourlyData,
    this.showHourDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade100, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayLabel,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            if (showHourDetails)
              SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // axe horizontal plus joli pour defile
                child: Row(
                  children: hourlyData.map((hour) {
                    return GestureDetector(
                      onTap: () {
                        // la popup quand je clique sur une heure pour les details
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.teal.shade50,
                            title: Center(
                              child: Text(
                                "Détails à ${(hour['heure'] ?? '').replaceAll(':', 'h')}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _infoRow(
                                  Icons.thermostat,
                                  "Température",
                                  hour['temp'],
                                  Colors.orange,
                                ),
                                _infoRow(
                                  Icons.device_thermostat,
                                  "Ressentie",
                                  hour['feels_like'],
                                  Colors.redAccent,
                                ),
                                _infoRow(
                                  Icons.water_drop,
                                  "Humidité",
                                  hour['humidity'],
                                  Colors.blue,
                                ),
                                _infoRow(
                                  Icons.air,
                                  "Vent",
                                  hour['wind'],
                                  Colors.grey,
                                ),
                                _infoRow(
                                  Icons.umbrella,
                                  "Précipitations",
                                  hour['precip'],
                                  Colors.indigo,
                                ),
                                _infoRow(
                                  Icons.cloud,
                                  "Nuages",
                                  hour['clouds'],
                                  Colors.blueGrey,
                                ),
                              ],
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Fermer",
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: Column(
                          children: [
                            Text(
                              hour['heure'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              hour['temp'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              hour['icon'] ?? '',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            else if (hourlyData.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(
                    Icons.thermostat,
                    "Température",
                    hourlyData[0]['temp'],
                    Colors.orange,
                  ),
                  _infoRow(
                    Icons.device_thermostat,
                    "Ressentie",
                    hourlyData[0]['feels_like'],
                    Colors.redAccent,
                  ),
                  _infoRow(
                    Icons.water_drop,
                    "Humidité",
                    hourlyData[0]['humidity'],
                    Colors.blue,
                  ),
                  _infoRow(
                    Icons.air,
                    "Vent",
                    hourlyData[0]['wind'],
                    Colors.grey,
                  ),
                  _infoRow(
                    Icons.umbrella,
                    "Précipitations",
                    hourlyData[0]['precip'],
                    Colors.indigo,
                  ),
                  _infoRow(
                    Icons.cloud,
                    "Nuages",
                    hourlyData[0]['clouds'],
                    Colors.blueGrey,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ligne avec une icône, un label, et la valeur météo
  Widget _infoRow(IconData icon, String label, String? value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(
            "$label : ${value ?? '--'}",
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
