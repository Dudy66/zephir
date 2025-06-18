import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherService {
  // Suggestions de ville
  static Future<List<Map<String, dynamic>>> getCitySuggestions(
    String query,
  ) async {
    final url = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=5&language=fr',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          return List<Map<String, dynamic>>.from(data['results']);
        }
      }
    } catch (err) {
      print("Erreur lors de la recherche de ville : $err");
    }

    return [];
  }

  // je recupere les previsions heure par heure
  static Future<Map<String, List<Map<String, String>>>>
  fetchGroupedHourlyWeather(
    String lat,
    String lon,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);

    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$lat&longitude=$lon'
      '&start_date=$start&end_date=$end'
      '&hourly=temperature_2m,apparent_temperature,relative_humidity_2m,'
      'windspeed_10m,precipitation,cloudcover,weathercode',
    );

    try {
      final res = await http.get(url);
      if (res.statusCode != 200) {
        print("Erreur dans la réponse météo");
        return {};
      }

      final jsonData = json.decode(res.body);
      final data = jsonData['hourly'];

      final times = data['time'] as List;
      final temps = data['temperature_2m'] as List;
      final feelsLike = data['apparent_temperature'] as List;
      final humidity = data['relative_humidity_2m'] as List;
      final wind = data['windspeed_10m'] as List;
      final rain = data['precipitation'] as List;
      final clouds = data['cloudcover'] as List;

      Map<String, List<Map<String, String>>> groupedData = {};

      for (int i = 0; i < times.length; i++) {
        final dt = DateTime.parse(times[i]);
        final day = DateFormat('EEEE d MMMM', 'fr_FR').format(dt);
        final hour = DateFormat('HH:mm').format(dt);

        final icon = (clouds[i] as num) < 30
            ? '☀️'
            : (clouds[i] as num) < 70
            ? '⛅'
            : '☁️';

        if (!groupedData.containsKey(day)) {
          groupedData[day] = [];
        }

        groupedData[day]!.add({
          "heure": hour,
          "temp": "${temps[i].round()}°",
          "feels_like": "${feelsLike[i].round()}°",
          "humidity": "${humidity[i]}%",
          "wind": "${wind[i]} km/h",
          "precip": "${rain[i]} mm",
          "clouds": "${clouds[i]}%",
          "icon": icon,
        });
      }

      return groupedData;
    } catch (e) {
      print("Erreur lors du chargement météo : $e");
      return {};
    }
  }
}
