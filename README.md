# 🌤 Zéphyr - Application Météo Flutter

Bienvenue sur **Zéphyr**, une application météo simple et moderne développée en **Flutter**.  
Elle permet de consulter la météo locale ou d'autres villes, avec des animations, des favoris, et plus encore.

---

## ✨ Fonctionnalités principales

- 🔍 Recherche de ville avec **autocomplétion**
- 🌍 Météo locale via **géolocalisation**
- ♥️ Ajout aux favoris avec **type personnalisé** (maison, vacances…)
- 🌧️ Prévisions **heure par heure**, regroupées par jour
- 🌈 Animations **Lottie** selon la météo (soleil, nuages…)
- 🔄 Rafraîchissement facile de la météo actuelle
- 📅 Choix rapide de la date (J+0, J+1, J+3, J+7)
- 🗺️ Toggle **ville / coordonnées GPS**

---

## 🔧 Lancer le projet

```bash
flutter pub get
flutter run
```

✅ Testé sur Android (émulateur & appareil réel) et iOS (Xcode + simulateur)

---

## ⚙️ Packages / dépendances

Voici les packages utilisés dans le projet, avec leur utilité et les ressources suivies pour les comprendre :

| Package               | Utilité principale                                        |
|-----------------------|-----------------------------------------------------------|
| [`http`](https://pub.dev/packages/http) | Pour récupérer les données météo depuis l'API |
| [`geolocator`](https://pub.dev/packages/geolocator) | Pour accéder à la position de l'utilisateur |
| [`permission_handler`](https://pub.dev/packages/permission_handler) | Pour demander les permissions de localisation |
| [`lottie`](https://pub.dev/packages/lottie) | Pour afficher des animations météo |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Pour enregistrer les favoris localement |
| [`intl`](https://pub.dev/packages/intl) | Pour formater les dates |
| [`flutter_localizations`](https://docs.flutter.dev/ui/accessibility-and-localization/internationalization) | Pour afficher l’interface en français |

---

## 📚 Détails et tutos suivis

### 🛰 http
- Récupération des données météo (Open-Meteo)
- Suggestions de villes via autocomplétion
- 📺 [GET request avec Flutter](https://www.youtube.com/watch?v=8Tu9Gjs3xcM)

---

### ❤️ shared_preferences
- Sauvegarde des villes favorites localement (même après redémarrage)
- 📺 [Favoris avec Flutter](https://www.youtube.com/watch?v=Ccd5fIrCDSY)
- 📺 [Local Storage tuto](https://www.youtube.com/watch?v=O72HfMS19F0)

---

### 📅 intl
- Formatage des dates comme "mardi 11 juin à 14h"
- 📘 [Documentation officielle](https://pub.dev/packages/intl)

---

### 📍 geolocator
- Récupère la position de l’utilisateur automatiquement
- 📺 [Geolocator Exemple – pub.dev](https://pub.dev/packages/geolocator/example)
- 📺 [Flutter Geolocator Tuto 1](https://www.youtube.com/watch?v=bpKxAPm1Cig)
- 📺 [Flutter Geolocator Tuto 2](https://www.youtube.com/watch?v=BkBQ5A0SQmM)
- 📺 [Geolocator Complet](https://www.youtube.com/watch?v=BKTGE2gy4Kw)

---

### 🔐 permission_handler
- Popup de demande de permission de localisation
- 📘 [Documentation officielle](https://pub.dev/packages/permission_handler)
- 📘 [Medium tuto](https://medium.com/@dudhatkirtan/how-to-use-permission-handler-in-flutter-db964943237e)
- 📺 [Flutter Permission handler](https://www.youtube.com/watch?v=XJlMxUcO1K4)
- 📺 [Request Permission tuto](https://www.youtube.com/watch?v=N7APZJAsx_4)

---

### 🌤 lottie
- Affichage d'animations météo (JSON animés)
- 📺 [Lottie avec Flutter](https://www.youtube.com/watch?v=MN1AWvYJgkE)

---

## 📷 Captures d’écran (comme j’imaginais l’application au début)

### Schema 1 
![Schema_1](screenshots/schema_1.png)

### Schema 2 
![Schema_2](screenshots/schema_2.png)

---

## 📷 Captures d’écran

### 🏠 Accueil
![Accueil](screenshots/Acceuil.png)

### 🔍 Autocomplétion des villes
![Autocomplete](screenshots/autocomplete.png)

### 📊 Détails météo heure par heure
![Card details](screenshots/card_details.png)

### 📍 Chargement via géolocalisation
![Chargement position](screenshots/chargement_position.png)

### ❓ Demande de permission de géolocalisation
![Demande géoloc](screenshots/demande_geoloc.png)

### ⏱ Heure par heure
![Heure par heure](screenshots/heure_par_heure.png)
---

## 📁 Structure du projet

```
lib/
├── main.dart
├── models/
│   └── favorite_city.dart
├── services/
│   ├── weather_service.dart
│   ├── weather_geoloc_service.dart
│   └── favorite_city_service.dart
├── widgets/
│   ├── city_search_field.dart
│   ├── current_weather_card.dart
│   ├── favorite_card.dart
│   ├── favorite_city_tile.dart
│   └── weather_day_card.dart
└── pages/
    └── home_page.dart
```

---

## 📡 API utilisée

- [Open-Meteo API](https://open-meteo.com/) – pour la météo

---

## Remerciements

Ce projet m’a permis de découvrir et mettre en pratique des concepts fondamentaux de Flutter. 💙


