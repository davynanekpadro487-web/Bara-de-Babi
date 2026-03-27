# 🛠️ Configuration du Projet — Barra de Babi

## 🚀 Installation & Lancement

Ce guide vous permet de configurer l'environnement **Frontend Flutter** pour Barra de Babi.

### 1. Prérequis
- **Flutter SDK** : v3.19.0 ou plus récent.
- **Android Studio / Xcode** : Installé avec les émulateurs configurés.
- **VS Code** : Avec l'extension Dart & Flutter (recommandé).

### 2. Installation des Dépendances
Dans le dossier racine `bara_2_babi/`, exécutez :
```bash
flutter pub get
```

### 3. Lancement de l'Application
Vérifiez que vos appareils/émulateurs sont connectés :
```bash
flutter devices
```
Puis lancez l'application :
```bash
flutter run
```

## 📋 Mode Simulation Active
Le projet est actuellement en **mode simulation totale** (Groupe 1 : Frontend UI). 
Aucun backend Node.js/Python n'est requis au lancement local tant que le Groupe 2 n'a pas livré les APIs finales.

- **Données simulées** : Utilisateurs, artisans, missions, messages et paiements sont gérés dans les services Flutter.
- **Identifiants Démo** : 
  - **Numéro de téléphone** : N'importe quel numéro à 10 chiffres.
  - **Code OTP** : `1234`

## 🗂️ Structure du Projet (Frontend)
- `lib/core/` : Thème, Couleurs (Custom Lamborghini), Constantes.
- `lib/screens/` : Les 36 écrans implémentés (Auth, Home, Missions, Artisan Dashboard).
- `lib/widgets/` : Composants premium réutilisables (GlassContainer, GoldButtons, Cards).
- `lib/models/` : Classes de données (User, Mission, Message) conformes à l'UML.

## 🐛 Dépannage
- Si vous rencontrez un problème de rendu des polices, assurez-vous que `google_fonts` est bien téléchargé.
- En cas d'erreur de build Android, exécutez : `flutter clean` suivi de `flutter build apk --debug`.

---
**Groupe 1 — Flutter Frontend Team.**
