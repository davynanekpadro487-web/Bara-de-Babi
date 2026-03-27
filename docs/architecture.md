# 🗺️ Architecture & Navigation Map — Barra de Babi

Ce document est la carte maîtresse du projet. Il permet de situer chaque écran, son fichier source et sa fonction précise dans le flux utilisateur.

---

## 🏗️ Structure Globale du Code
- **`/lib/core`** : Système nerveux (Thème Lamborghini, Couleurs, Constantes).
- **`/lib/models`** : Squelette de données (Contrats UML pour User, Mission, Message).
- **`/lib/widgets`** : Composants atomiques premium (GlassContainer, GoldButtons, Cards).
- **`/lib/screens`** : Les 36 organes (Écrans) de l'application.

---

## 📍 Plan de Navigation (36 Écrans)

### 1. Flux d'Entrée & Authentification
| ID | Écran | Fichier Source | Fonction |
| :--- | :--- | :--- | :--- |
| **01** | Splash Screen | `splash_screen.dart` | Animation d'entrée et branding luxe. |
| **02-04** | Onboarding | `onboarding_screen.dart` | Présentation des 3 piliers du service. |
| **05-07** | Authentification | `auth_screen.dart` | Phone Login, OTP et Choix du rôle (Client/Artisan). |

### 2. Parcours Profil & KYC (Validation)
| ID | Écran | Fichier Source | Fonction |
| :--- | :--- | :--- | :--- |
| **08** | Profil Création | `kyc_screens.dart` | Saisie du Nom/Prénom et Photo (Simulation). |
| **09-10** | Upload CIN | `kyc_screens.dart` | Gestion de l'identité (Recto/Verso). |
| **11** | Spécialité | `kyc_screens.dart` | Choix du métier (uniquement pour Artisans). |
| **12** | Attente KYC | `kyc_screens.dart` | Mur d'attente de validation administrative. |

### 3. Espace Client (Recherche & Annuaire)
| ID | Écran | Fichier Source | Fonction |
| :--- | :--- | :--- | :--- |
| **13** | Home Client | `client_home_screen.dart` | Dashboard, Demande Express, Catégories. |
| **14-17** | Flux Express | `service_request_screen.dart` | Questionnaire rapide → Matching Artisan. |
| **18** | Annuaire | `artisan_directory_screen.dart` | Liste complète et recherche par filtres. |
| **19** | Profil Artisan | `artisan_directory_screen.dart` | Fiche détaillée (Modal) de l'artisan local. |

### 4. Suivi de Mission & Live Tracking
| ID | Écran | Fichier Source | Fonction |
| :--- | :--- | :--- | :--- |
| **20** | Live Tracking | `mission_screens.dart` | Carte temps réel avec déplacement de l'artisan. |
| **21** | Fiche Mission | `mission_screens.dart` | Détail de la mission en cours pour le client. |
| **22** | Chat | `chat_list_screen.dart` | Messagerie sécurisée entre les deux parties. |
| **23** | Notifications | `mission_screens.dart` | Centre d'alertes (Missions, Rappels). |
| **24** | Rating | `mission_screens.dart` | Notation et avis post-intervention. |
| **25** | Historique | `profile_screen.dart` | Liste des interventions passées du client. |

### 5. Espace Artisan (Dashboard & Revenus)
| ID | Écran | Fichier Source | Fonction |
| :--- | :--- | :--- | :--- |
| **26** | Home Artisan | `artisan_dashboard_screen.dart` | Tableau de bord, Note, Revenus du jour. |
| **27** | Toggle Dispo | `artisan_dashboard_screen.dart` | Mise en ligne/hors ligne (Switch animé). |
| **28-31** | Missions | `artisan_dashboard_screen.dart` | Réception, Détails, Navigation et Terminaison. |
| **32** | Stats Pro | `artisan_dashboard_screen.dart` | Graphiques de revenus et performances mensuelles. |
| **33** | Abonnement | `artisan_dashboard_screen.dart` | Plans (Starter/Pro/Premium) et paiement Wave/OM. |

### 6. Configuration & Support
| ID | Écran | Fichier Source | Fonction |
| :--- | :--- | :--- | :--- |
| **34** | Paramètres | `settings_screens.dart` | Modification compte, tarifs et horaires. |
| **35** | Bascule Rôle | `settings_screens.dart` | Switch instantané Client ↔ Artisan. |
| **36** | FAQ/Support | `artisan_dashboard_screen.dart` | Aide contextuelle et support technique. |

---

## 🧬 Logique de Flux (Roadmap)
1. **Entrée** : Splash → Onboarding → Auth.
2. **Identification** : Basé sur le rôle choisi dans `AuthScreen`, l'utilisateur est dirigé vers `ProfileCreationScreen`.
3. **Validation** : 
   - Client → Accueil Immédiat.
   - Artisan → KYC Obigatoire → Attente Validation → Dashboard.
4. **Interaction** : Tout part de l'Accueil (Client) ou du Dashboard (Artisan). Le point de rencontre est la **Mission** (`mission_screens.dart`).

---
**Note technique** : Les écrans 37, 38, 39 (Site Vitrine Web) sont exclus de cette architecture mobile.
