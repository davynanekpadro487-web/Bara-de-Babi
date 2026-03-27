# 🧠 Contexte & Objectif Majeur — Barra de Babi

Ce document sert de "Mémoire Centrale" pour le projet. Il définit la vision, les règles critiques et l'état des modules stables pour éviter toute régression ou modification inutile.

---

## 🎯 Vision & Objectif Global
**Objectif** : Créer une interface Flutter ultra-premium (Luxe) pour le service de dépannage "Barra de Babi".
**Inspiration** : [Lamborghini.com](https://www.lamborghini.com/fr-en) (Moderne, Sombre, Or, Dynamique).
**Périmètre Actuel** : Simulation Frontend complète (Groupe 1). **AUCUNE LOGIQUE MÉTIER RÉELLE** (Business Logic) ne doit être ajoutée pour l'instant afin de rester concentré sur l'expérience utilisateur (UI/UX).

---

## 💎 Principes de Design (Loi Lamborghini)
1. **Couleurs** : Background `#0A0A0A`, Accents `#D4AF37` (Gold), Orange Lamborghini pour les alertes/actions.
2. **Effets** : Glassmorphism (verre dépoli), dégradés subtils, micro-animations de transition.
3. **Typographie** : `Outfit` pour les titres (Majuscules), `Inter` pour les textes secondaires.
4. **Composants** : Utiliser EXCLUSIVEMENT les widgets personnalisés (`GlassContainer`, `GoldButton`, `GhostButton`, `ArtisanCard`, etc.).

---

## 🛡️ Règles de Sécurité (Protection du Code)
- **NE PAS MODIFIER** : Les modèles de données (`lib/models/`) qui sont déjà alignés sur l'UML et les APIs futures.
- **NE PAS TOUCHER** : Les écrans marqués comme **STABLES** dans la liste ci-dessous, sauf demande explicite pour une mise à jour design.
- **VÉRIFICATION** : Avant chaque modification de fichier, vérifier son impact sur les flux liés (ex: Modifier l'Auth peut casser le KYC).

---

## ✅ État des Modules (Verrouillage)

| Module | État | Fichiers Clés | Note |
| :--- | :--- | :--- | :--- |
| **Fondations** | 🟢 STABLE | `core/colors.dart`, `core/theme.dart`, `widgets/` | Ne pas modifier sans accord design général. |
| **Auth & KYC** | 🟢 STABLE | `auth_screen.dart`, `kyc_screens.dart` | Flux complet de 01 à 12 validé. |
| **Client Core** | 🟢 STABLE | `client_home_screen.dart`, `artisan_directory_screen.dart` | Recherche express fonctionnelle. |
| **Suivi Mission** | 🟢 STABLE | `mission_screens.dart` | Tracking et notation simulés. |
| **Espace Artisan** | 🟢 STABLE | `artisan_dashboard_screen.dart` | Dashboard, Stats, Abonnement. |
| **Paramètres** | 🟢 STABLE | `settings_screens.dart` | Bascule de rôle et profil. |

---

## 📝 Historique des Prompts Majeurs
> "on va refaire completement le front tout modifier voir meme supprimer, prends connaisssances de nouveaux doc à suivre dans le dossier contexte , le but est de faire un front qui suit les docs et panel choisin abandonné toute trace de l'ancienne version et fait ça avec une design du site : https://www.lamborghini.com"

> "selon le pdf on doit avoir 39 ecrans"

> "je rappelle qu'il ne doit y avoir aucune loquie metier juste de la simul pour le front"

> "on laisse la partie de site vitrine c'est autre chose"

---

## 🚀 Prochaines Étapes Validées
1. **Optimisation QA** : Chasse aux bugs d'affichage sur petits écrans.
2. **Polish Graphique** : Ajouter des animations Lottie pour les succès (KYC validé, Paiement réussi).
3. **Préparation Groupe 2** : Rester prêt pour l'intégration API réelle quand le backend sera livré.
