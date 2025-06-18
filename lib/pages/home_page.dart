import 'package:flutter/material.dart';
import 'package:zephir/models/favorite_city.dart';
import 'package:zephir/services/weather_service.dart';
import 'package:zephir/services/favorite_city_service.dart';
import 'package:zephir/services/weather_geoloc_service.dart';
import 'package:zephir/widgets/current_weather_card.dart';
import 'package:zephir/widgets/weather_day_card.dart';
import 'package:zephir/widgets/favorite_card.dart';
import 'package:zephir/widgets/rainbow_switch.dart';
import 'package:zephir/widgets/city_search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Je crée des contrôleurs pour récupérer ce que le user tape
  final _cityController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();

  //scroll pour renvoyer vers la meteo h/h
  final _scrollController = ScrollController();
  final _weatherKey = GlobalKey();

  bool _useCity = true;
  String? _currentCityName;
  String? _errorMessage;
  DateTime? _startDate;
  DateTime? _endDate;
  Map<String, dynamic>? _selectedCityData;

  //preparation des favoris et meteo du jour
  final _favService = FavoriteCityService();
  List<FavoriteCity> _favorites = [];
  Map<String, List<Map<String, String>>> _groupedWeather = {};

  // lors du lancement de lappli je charge les fav et localisation pour afficher meteo
  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _fetchWeatherFromLocation();
  }

  void _loadFavorites() async {
    final favs = await _favService.getFavorites();
    setState(() => _favorites = favs);
  }

  // recupere la localition du user
  void _fetchWeatherFromLocation() async {
    final pos = await WeatherGeolocService.getCurrentPosition();
    if (pos != null) {
      _latController.text = pos.latitude.toString();
      _lonController.text = pos.longitude.toString();
      setState(() {
        _useCity = false;
        _currentCityName = "Votre position";
        _startDate = DateTime.now();
        _endDate = _startDate!.add(const Duration(days: 0));
      });
      _fetchWeather();
    }
  }

  // Je choisis les jours à afficher
  void _setDays(int offset) {
    _startDate = DateTime.now();
    _endDate = _startDate!.add(Duration(days: offset));
    _fetchWeather();
  }

  // Je récupère la météo selon ville ou coordonnées
  void _fetchWeather() async {
    setState(() => _errorMessage = null);

    String? lat;
    String? lon;

    if (_useCity) {
      if (_selectedCityData == null) {
        setState(() => _errorMessage = "Aucune ville sélectionnée.");
        return;
      }
      lat = _selectedCityData!['latitude'].toString();
      lon = _selectedCityData!['longitude'].toString();
      _currentCityName = _selectedCityData!['name'];
    } else {
      lat = _latController.text.trim();
      lon = _lonController.text.trim();
      _currentCityName = "Coordonnées";
      if (lat.isEmpty || lon.isEmpty) return;
    }

    if (_startDate == null || _endDate == null) return;

    final weather = await WeatherService.fetchGroupedHourlyWeather(
      lat,
      lon,
      _startDate!,
      _endDate!,
    );
    setState(() => _groupedWeather = weather);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_weatherKey.currentContext != null) {
        Scrollable.ensureVisible(
          _weatherKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // type pour ajouter ua favoris
  void _showTypeDialogAndAddFavorite() {
    if (_selectedCityData == null) return;

    final name = _selectedCityData!['name'];
    final coords = [
      _selectedCityData!['latitude'],
      _selectedCityData!['longitude'],
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Choisir un type"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTypeOption(name, coords, 'Maison', Icons.home, Colors.blue),
            _buildTypeOption(
              name,
              coords,
              'Vacances',
              Icons.beach_access,
              Colors.orange,
            ),
            _buildTypeOption(
              name,
              coords,
              'Autre',
              Icons.location_city,
              Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeOption(
    String name,
    List coords,
    String type,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(type),
      onTap: () async {
        final fav = FavoriteCity(
          name: name,
          type: type,
          latitude: coords[0],
          longitude: coords[1],
        );
        await _favService.addFavorite(fav);
        _cityController.clear();
        _loadFavorites();
        if (mounted) Navigator.of(context).pop();
      },
    );
  }

  // Je supprime un favori
  void _removeFavorite(FavoriteCity city) async {
    await _favService.removeFavorite(city);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // J'affiche une bannière
                  Container(
                    margin: const EdgeInsets.only(bottom: 1),
                    height: 140,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/banniere.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // J'affiche la météo actuelle
                  CurrentWeatherCard(
                    cityName: _currentCityName ?? 'Chargement...',
                    weather: _groupedWeather.isNotEmpty
                        ? _groupedWeather.values.first.first
                        : {},
                    onRefreshLocation: _fetchWeatherFromLocation,
                    isLoading:
                        _groupedWeather.isEmpty || _currentCityName == null,
                  ),

                  const SizedBox(height: 16),

                  // petuit switch pour coord ou ville
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Coordonnées",
                        style: TextStyle(
                          color: !_useCity ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      RainbowSwitch(
                        value: _useCity,
                        onChanged: (val) => setState(() => _useCity = val),
                      ),
                      const SizedBox(width: 8),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: _useCity
                                ? [
                                    Colors.orange,
                                    Colors.pink,
                                    Colors.purple,
                                    Colors.blue,
                                  ]
                                : [Colors.grey.shade400, Colors.grey.shade400],
                          ).createShader(bounds);
                        },
                        child: Text(
                          "Ville",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // message derreur
                  if (_errorMessage != null) ...[
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],

                  const SizedBox(height: 12),

                  // J'affiche le formulaire selon le mode sélectionne
                  _useCity
                      ? CitySearchField(
                          controller: _cityController,
                          onCitySelected: (cityData) {
                            setState(() {
                              _selectedCityData = cityData;
                              _cityController.text = cityData['name'];
                            });
                            _setDays(0);
                          },
                          onHeartPressed: _showTypeDialogAndAddFavorite,
                        )
                      : Column(
                          children: [
                            TextField(
                              controller: _latController,
                              decoration: const InputDecoration(
                                hintText: "Latitude",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _lonController,
                              decoration: const InputDecoration(
                                hintText: "Longitude",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),

                  const SizedBox(height: 16),

                  // boutons pour les jours météo, je trouvais le datepicker pas tres ui/ux
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () => _setDays(0),
                        child: const Text("Aujourd'hui"),
                      ),
                      ElevatedButton(
                        onPressed: () => _setDays(1),
                        child: const Text("J+1"),
                      ),
                      ElevatedButton(
                        onPressed: () => _setDays(3),
                        child: const Text("J+3"),
                      ),
                      ElevatedButton(
                        onPressed: () => _setDays(7),
                        child: const Text("J+7"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // J'affiche les favoris
                  FavoriteCard(
                    favorites: _favorites,
                    onDelete: _removeFavorite,
                    onSelect: (city) async {
                      setState(() {
                        _useCity = true;
                        _cityController.text = city.name;
                        _selectedCityData = {
                          'name': city.name,
                          'latitude': city.latitude,
                          'longitude': city.longitude,
                        };
                      });
                      await Future.delayed(const Duration(milliseconds: 300));
                      _fetchWeather();
                    },
                  ),

                  const Divider(),
                  const SizedBox(height: 16),

                  // J'affiche la météo jour par jour
                  KeyedSubtree(
                    key: _weatherKey,
                    child: Column(
                      children: _groupedWeather.entries.map((entry) {
                        return WeatherDayCard(
                          dayLabel: entry.key,
                          hourlyData: entry.value,
                          showHourDetails: true,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
