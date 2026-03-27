# 📋 TODO - Barra de Babi - Frontend Flutter (Groupe 1)

Ce document répertorie les tâches selon le planning des **6 Sprints** définis pour le Groupe 1.

## 🎯 Objectifs (Groupe 1)
- Créer l'intégralité des screens (36 identifiés Flutter).
- Adhérer au Design System **Lamborghini** (Dark Luxury).
- Connecter les écrans aux APIs du Groupe 2 (Phase future).
- Tester sur Android (entrées de gamme) et iOS.

---

## 🏗️ Phase 1 : Design & Sprints UI (EN COURS)

### ✅ Complété - SPRINT 1 (Auth & KYC)
- [x] Splash Screen (01)
- [x] Onboarding 3 slides (02-04)
- [x] Inscription téléphone/OTP (05-06)
- [x] Choix du rôle Client/Artisan (07)
- [x] Création de profil (08)
- [x] KYC Upload Recto/Verso CIN (09-10)
- [x] KYC Choix spécialité (11)
- [x] Écran attente validation (12)

### ✅ Complété - SPRINT 2 (Recherche & Annuaire)
- [x] Accueil Client - Bouton Demande Express (13)
- [x] Sélection catégorie (14)
- [x] Sélection sous-problème (15)
- [x] Animation de recherche d'artisan (16)
- [x] Résultat Artisan trouvé (17)
- [x] Annuaire des artisans (18)
- [x] Profil détaillé artisan (19)

### ✅ Complété - SPRINT 3 (Tracking & Interaction)
- [x] Carte Tracking Live - Position mobile artisan (20)
- [x] Mission en cours côté client (21)
- [x] Interface de Chat Client-Artisan (22)
- [x] Centre de notifications (23)
- [x] Notation étoiles post-mission (24)
- [x] Historique des missions client (25)

### ✅ Complété - SPRINT 4 (Dashboard Artisan & Paiements)
- [x] Dashboard Artisan (26)
- [x] Bouton Disponibilité ON/OFF animé (27)
- [x] Pop-up mission reçue - Accepter/Refuser (28)
- [x] Détail mission acceptée (29)
- [x] Carte navigation itinéraire (30)
- [x] Mission en cours côté artisan (31)
- [x] Historique & Stats artisan (32)
- [x] Gestion Abonnement & Paiement Wave/OM (33)

### ✅ Complété - SPRINT 5 (Paramètres & FAQ)
- [x] Paramètres compte (Modifier profil, horaires, prix) (34)
- [x] Bascule de rôle Client/Artisan (35)
- [x] FAQ & Formulaire de support (36)

---

## � 🔄 Phase 2 : Optimisations & QA (À FAIRE)

### � Optimisation Performance
- [ ] Optimiser les images pour les téléphones d'entrée de gamme (3G).
- [ ] Mettre en cache les données d'annuaire.
- [ ] Améliorer les transitions entre les écrans complexes.

### 🧪 Tests & Corrections
- [ ] Tester sur émulateurs Android avec faible RAM.
- [ ] Corriger les bugs visuels d'overflow sur petits écrans.
- [ ] Valider l'accessibilité (contraste, taille texte).

---

## 📋 🔌 Phase 3 : Mobilité & Intégration API (À FAIRE)

### 🔧 Connexion Groupe 2 (Backend)
- [ ] Connecter l'authentification réelle.
- [ ] Brancher CRUD Utilisateur sur les APIs réelles.
- [ ] Intégrer les WebSockets pour le Chat réel.
- [ ] Connecter le flux "Demande Express" à l'algorithme réel du Groupe 2.

### � Géolocalisation Réelle
- [ ] Intégrer le package `Mapbox GL` ou `Google Maps`.
- [ ] Afficher la position GPS réelle de l'utilisateur et de l'artisan.
- [ ] Calculer l'ETA dynamiquement via API.

### 💸 Paiements Réels
- [ ] Intégrer les SDKs officiels Wave CI.
- [ ] Intégrer les SDKs Orange Money (CinetPay ou direct).

---

## 🎯 Échéance Finale
- **Déploiement Production** : À la fin du Sprint 6.
- **Publication App Store/Play Store** : Version Bêta prévue.

---
**Dernière mise à jour** : 09-03-2026
**Responsable** : Groupe 1 Frontend.
