# 🌬️ Zéphyr - Application Météo Flutter

Bienvenue sur **Zéphyr**, une application météo simple, moderne et fonctionnelle développée en **Flutter** 
---

## ✨ Fonctionnalités principales

* 🔍 Recherche de ville avec **autocomplétion**
* 🌍 Météo locale via **géolocalisation**
* ❤️ Ajout aux **favoris** avec **type personnalisé** (maison, vacances...)
* ☂️ Prévision **heure par heure** regroupée par **jour**
* 🌌 **Animations Lottie** selon la météo (soleil, nuages...)
* ↺ Rafraîchissement rapide avec position actuelle

---

## 🛠️ Lancer le projet

```bash
flutter pub get
flutter run
```

Compatible Android (téléphone & émulateur) et iOS (simu + Xcode).

---

## ⚖️ Packages / dépendances utilisées

| Package                 | Utilité                                               |
| ----------------------- | ----------------------------------------------------- |
| `http`                  | Appels à l'API Open-Meteo + autocomplétion des villes |
| `geolocator`            | Récupération de la position GPS de l'utilisateur      |
| `permission_handler`    | Demander les autorisations de localisation            |
| `lottie`                | Affichage des animations JSON (soleil, nuage...)      |
| `shared_preferences`    | Sauvegarde des favoris localement sur le téléphone    |
| `intl`                  | Formatage des dates (mardi 11 juin à 14h)             |
| `flutter_localizations` | Localisation en français                              |

---

## 🔍 Détails et ressources suivies

### 🚀 `http`

* Pour récupérer les données météo de l'API Open-Meteo
* Pour récupérer des suggestions de villes (autocomplétion)

→ Docs / tutos :
[https://pub.dev/packages/http](https://pub.dev/packages/http)
[🎥 GET Request Flutter (YouTube)](https://www.youtube.com/watch?v=8Tu9Gjs3xcM)

### ❤️ `shared_preferences`

* Pour sauvegarder les villes favorites dans le stockage local.

→ Docs / tutos :
[https://pub.dev/packages/shared\_preferences](https://pub.dev/packages/shared_preferences)
[🎥 Favoris avec Flutter](https://www.youtube.com/watch?v=Ccd5fIrCDSY)
[🎥 Local storage Flutter](https://www.youtube.com/watch?v=O72HfMS19F0)

### 🗓 `intl`

* Pour formater les dates et heures correctement.

→ Docs :
[https://pub.dev/packages/intl](https://pub.dev/packages/intl)

### 📍 `geolocator`

* Pour accéder à la position GPS à l'ouverture de l'app.

→ Tutos :
[https://pub.dev/packages/geolocator/example](https://pub.dev/packages/geolocator/example)
[🎥 Geolocator usage](https://www.youtube.com/watch?v=bpKxAPm1Cig)
[🎥 GPS Position Flutter](https://www.youtube.com/watch?v=BkBQ5A0SQmM)
[🎥 Geolocator complet](https://www.youtube.com/watch?v=BKTGE2gy4Kw)

### 🔐 `permission_handler`

* Pour gérer les permissions utilisateur de manière propre.

→ Docs :
[https://pub.dev/packages/permission\_handler](https://pub.dev/packages/permission_handler)
[🎥 Flutter Permission Handler](https://www.youtube.com/watch?v=XJlMxUcO1K4)
[🎥 Request Permission](https://www.youtube.com/watch?v=N7APZJAsx_4)

### ☀️ `lottie`

* Pour rendre l'interface plus vivante avec des animations JSON adaptées à la météo.

→ Docs :
[https://pub.dev/packages/lottie](https://pub.dev/packages/lottie)
[🎥 Lottie Flutter](https://www.youtube.com/watch?v=FjqMIy803yQ)

---

## 🌟 Bonus ajoutés

* ⏺ **Toggle "ville / coordonnées"**
* 🛏️ Design adapté mobile, visuel moderne
* ⚠️ Gestion d'erreurs (pas de GPS, ville vide...)
* 🔄 Scroll automatique vers la météo après sélection

---

## 📷 Captures d'écran (vraie interface actuelle)

### 🏠 Accueil

![Accueil](https://raw.githubusercontent.com/Dudy66/zephir/main/screenshots/Acceuil.png)

### 🔍 Autocomplétion

![Autocomplétion](https://raw.githubusercontent.com/Dudy66/zephir/main/screenshots/autocomplete.png)

### 📊 Détails heure par heure

![Détails](https://raw.githubusercontent.com/Dudy66/zephir/main/screenshots/heure_par_heure.png)

### ❤️ Favoris

![Favoris](https://raw.githubusercontent.com/Dudy66/zephir/main/screenshots/card_details.png)

### 📍 Chargement par position

![Géoloc](https://raw.githubusercontent.com/Dudy66/zephir/main/screenshots/chargement_position.png)

### ❓ Demande de permission GPS

![Permission](https://raw.githubusercontent.com/Dudy66/zephir/main/screenshots/demande_geoloc.png)

---

## 🗂️ Captures d'écran (comme j'imaginais au début)

### Schéma 1

![Schema 1](https://raw.githubusercontent.com/Dudy66/zephir/main/screenshots/schema_1.png)

### Schéma 2

![Schema 2](https://firebasestorage.googleapis.com/v0/b/overlookapp-b9e00.firebasestorage.app/o/projet%2Fschema_2.png?alt=media&token=4c4edf82-38b3-4c29-9fea-5140d39bdf34)

---

## 📁 Structure du projet (lib)

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

## 📶 Liens utiles

* API utilisée : [Open-Meteo](https://open-meteo.com/)
* Tutos & démos : voir plus haut ▲ ou dans les commentaires du code
* Repos GitHub : [github.com/Dudy66/zephir](https://github.com/Dudy66/zephir)

---

Merci AquaTech pour ce test motivant 🙏 !

---
