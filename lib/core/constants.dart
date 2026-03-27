/// Constantes globales de Barra de Babi
class AppConstants {
  AppConstants._();

  // ─── App Info ─────────────────────────────────────
  static const String appName = 'BARRA DE BABI';
  static const String appTagline = 'Lève-toi et va, brobro';
  static const String appDescription =
      'Plateforme de mise en relation Artisans-Clients à Abidjan';
  static const String appVersion = '2.0.0';

  // ─── API ──────────────────────────────────────────
  static const String baseUrl = 'http://localhost:3000/api';

  // ─── Catégories de Métiers ────────────────────────
  static const List<Map<String, dynamic>> serviceCategories = [
    {
      'id': 'plomberie',
      'name': 'PLOMBERIE',
      'icon': '🔧',
      'description': 'Réparations, installations sanitaires',
      'subProblems': [
        'Fuite de robinet',
        'Toilette bouchée',
        'Chauffe-eau en panne',
        'Installation sanitaire',
        'Canalisation bouchée',
      ],
    },
    {
      'id': 'electricite',
      'name': 'ÉLECTRICITÉ',
      'icon': '⚡',
      'description': 'Installations, dépannage électrique',
      'subProblems': [
        'Panne de courant',
        'Installation prise/interrupteur',
        'Câblage maison',
        'Tableau électrique',
        'Éclairage extérieur',
      ],
    },
    {
      'id': 'menuiserie',
      'name': 'MENUISERIE',
      'icon': '🪚',
      'description': 'Meubles, portes, aménagements bois',
      'subProblems': [
        'Porte cassée',
        'Meuble sur mesure',
        'Placard encastré',
        'Terrasse en bois',
        'Réparation mobilier',
      ],
    },
    {
      'id': 'couture',
      'name': 'COUTURE',
      'icon': '🧵',
      'description': 'Confection, retouches vestimentaires',
      'subProblems': [
        'Confection tenue',
        'Retouche vêtement',
        'Rideaux sur mesure',
        'Uniforme scolaire',
        'Tenue traditionnelle',
      ],
    },
    {
      'id': 'mecanique',
      'name': 'MÉCANIQUE',
      'icon': '🔩',
      'description': 'Réparation, entretien automobile',
      'subProblems': [
        'Réparation moteur',
        'Vidange',
        'Diagnostic auto',
        'Freins',
        'Climatisation auto',
      ],
    },
    {
      'id': 'coiffure',
      'name': 'COIFFURE',
      'icon': '💇',
      'description': 'Coiffure homme et femme à domicile',
      'subProblems': [
        'Coupe homme',
        'Tresses',
        'Tissage',
        'Coloration',
        'Coiffure mariage',
      ],
    },
    {
      'id': 'peinture',
      'name': 'PEINTURE',
      'icon': '🎨',
      'description': 'Peinture intérieure et extérieure',
      'subProblems': [
        'Peinture chambre',
        'Peinture façade',
        'Peinture décorative',
        'Ravalement',
        'Étanchéité',
      ],
    },
    {
      'id': 'maconnerie',
      'name': 'MAÇONNERIE',
      'icon': '🧱',
      'description': 'Construction, réparation bâtiment',
      'subProblems': [
        'Mur fissuré',
        'Carrelage',
        'Dalles',
        'Clôture',
        'Extensions',
      ],
    },
  ];
}
