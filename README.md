# 🌬️ Zéphyr - Application Météo Flutter

Bienvenue sur **Zéphyr**, une application météo simple et moderne développée en Flutter.

---

## ✨ Fonctionnalités principales

* 🔍 **Recherche de ville avec autocomplétion**
* 🌍 **Météo locale via géolocalisation**
* ♥️ **Ajout aux favoris avec type personnalisé (maison, vacances...)**
* 🌧️ **Prévision heure par heure** regroupée par jour
* 🌌 **Animations Lottie** selon la météo (soleil, nuages...)
* 🔄 Rafraîchissement facile de la météo actuelle

---

## 🔧 Lancer le projet

```bash
flutter pub get
flutter run
```

> ✅ Testé sur Android (emulateur & appareil) et iOS (Xcode + simulateur)

---

⚙️ Packages / Dépendances utilisées

Voici les packages que j’ai utilisés dans l’app, et pourquoi je les ai choisis. Je mets aussi les liens vers les docs ou tutos que j’ai suivis pour apprendre à les utiliser.

Voici les principales dépendances utilisées dans le projet et pourquoi je les ai choisies :

| Package               | Utilité                                                      |
| ----------------------| ------------------------------------------------------------ |
| http                  | Pour récupérer les données météo depuis l'API                |
| geolocator            | Pour accéder à la position de l'utilisateur                  |
| permission_handler    | Pour demander les permissions de localisation                |
| lottie                | Pour afficher de jolies animations météo (soleil, nuages...) |
| shared_preferences    | Pour enregistrer les villes favorites localement             |
| intl                  | Pour formater les dates                                      |
| flutter_localizations | Pour afficher l’interface en français                        |


⸻

🔍 Détails et ressources suivies

⸻

🛰 http

J’ai utilisé http pour :
	•	récupérer les données météo depuis l’API Open-Meteo
	•	récupérer des suggestions de villes en tapant du texte

🔗 Tutos suivis :
	•	https://pub.dev/packages/http
	•	📺 YouTube – GET request Flutter

⸻

❤️ shared_preferences

Ce package m’a servi pour sauvegarder les favoris localement (dans la mémoire du téléphone), même après redémarrage.

🔗 Tutos suivis :
	•	https://pub.dev/packages/shared_preferences
	•	📺 YouTube – Favoris avec Flutter
	•	📺 YouTube – Local Storage tuto

⸻

📅 intl

Je m’en suis servi pour formater les dates et afficher des choses comme “Mardi 11 juin à 14h”.

🔗 Doc :
	•	https://pub.dev/packages/intl

⸻

📍 geolocator

Ce package m’a permis d’accéder à la position de l’utilisateur au lancement de l’app.

🔗 Tutos que j’ai suivis :
	•	https://pub.dev/packages/geolocator/example
	•	📺 Utiliser geolocator
	•	📺 Flutter Position
	•	📺 Geolocator complet

⸻

🔐 permission_handler

Je l’ai utilisé pour demander la permission de localisation (popup au début).

🔗 Références :
	•	https://pub.dev/packages/permission_handler
	•	📘 Medium tuto
	•	📺 Permission handler Flutter
	•	📺 Request Permission tuto

⸻

🌤 lottie

Je m’en suis servi pour afficher des animations météo (soleil, nuages…) avec des fichiers .json animés.

🔗 Tutos :
	•	https://pub.dev/packages/lottie
	•	📺 Lottie pour Flutter

## 📅 Bonus ajoutés

* Toggle "ville / coordonnées" pour changer la façon de rechercher
* Design adapté mobile, avec effet visuel moderne
* Gestion des erreurs (ville non trouvée, pas de GPS...)
* Scroll automatique vers la météo après recherche

---

## 📷 Captures d’écran

### 🏠 Accueil

![Accueil](screenshots/Accueil.png)

### 🔍 Autocomplétion des villes

![Autocomplétion](screenshots/autocomplete.png)

### 📊 Détails météo heure par heure

![Détails](screenshots/heure_par_heure.png)

### ♥️ Ajout aux favoris

![Favoris](screenshots/card_details.png)

### 📍 Chargement via géolocalisation

![Géoloc](screenshots/chargement_position.png)

### ❓ Demande de permission de localisation

![Permission](screenshots/demande_geoloc.png)

---

## 📁 Structure du projet (extrait)

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

## 📡 Liens utiles

* API utilisée : [Open-Meteo](https://open-meteo.com/)
* Dépendances : voir pubspec.yaml
* Vidéos & docs consultées : voir commentaires dans le README ou dans les fichiers source

---

> Projet réalisé dans le cadre d'un test de recrutement

---

