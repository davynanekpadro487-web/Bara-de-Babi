/// Constantes globales de Barra de Babi
class AppConstants {
  AppConstants._();

  // ─── App Info ─────────────────────────────────────
  static const String appName = 'BARA DE BABI';
  static const String appTagline = 'Lève-toi et va, brobro';
  static const String appDescription =
      'Plateforme de mise en relation Prestataires-Clients à Abidjan';
  static const String appVersion = '2.0.0';

  // ─── API ──────────────────────────────────────────
  static const String baseUrl = 'http://localhost:3000/api';

  // ─── Catégories de Métiers ────────────────────────
  static const List<Map<String, dynamic>> serviceCategories = [
    {
      'id': 'plomberie',
      'name': 'Plomberie',
      'icon': '🔧',
      'colorName': 'blue',
      'description': 'Réparations, installations sanitaires',
      'subProblems': ['Fuite de robinet', 'Toilette bouchée', 'Chauffe-eau en panne'],
    },
    {
      'id': 'electricite',
      'name': 'Électricité',
      'icon': '⚡',
      'colorName': 'yellow',
      'description': 'Installations, dépannage électrique',
      'subProblems': ['Panne de courant', 'Installation prise', 'Câblage'],
    },
    {
      'id': 'menuiserie',
      'name': 'Menuiserie',
      'icon': '🪚',
      'colorName': 'orange',
      'description': 'Meubles, portes, aménagements bois',
      'subProblems': ['Porte cassée', 'Meuble sur mesure', 'Placard'],
    },
    {
      'id': 'couture',
      'name': 'Couture',
      'icon': '🧵',
      'colorName': 'pink',
      'description': 'Confection, retouches vestimentaires',
      'subProblems': ['Confection tenue', 'Retouche vêtement', 'Rideaux'],
    },
    {
      'id': 'mecanique',
      'name': 'Mécanique',
      'icon': '🔩',
      'colorName': 'purple',
      'description': 'Réparation, entretien automobile',
      'subProblems': ['Réparation moteur', 'Vidange', 'Diagnostic auto'],
    },
    {
      'id': 'coiffure',
      'name': 'Coiffure',
      'icon': '💇',
      'colorName': 'green',
      'description': 'Coiffure homme et femme à domicile',
      'subProblems': ['Coupe homme', 'Tresses', 'Tissage'],
    },
    {
      'id': 'peinture',
      'name': 'Peinture',
      'icon': '🎨',
      'colorName': 'blue',
      'description': 'Peinture intérieure et extérieure',
      'subProblems': ['Peinture chambre', 'Peinture façade', 'Peinture décorative'],
    },
    {
      'id': 'maconnerie',
      'name': 'Maçonnerie',
      'icon': '🧱',
      'colorName': 'orange',
      'description': 'Construction, réparation bâtiment',
      'subProblems': ['Mur fissuré', 'Carrelage', 'Dalles'],
    },
  ];
}
