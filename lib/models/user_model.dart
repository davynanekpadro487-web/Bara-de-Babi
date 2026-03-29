/// Modèle Utilisateur — conforme UML Barra de Babi
enum UserRole { client, prestataire, admin }

class UserModel {
  final String id;
  final String nom;
  final String prenom;
  final String? email;
  final String telephone;
  final String? photoUrl;
  final UserRole role;
  final bool estActif;
  final bool estBanni;
  final DateTime creeLe;
  final DateTime? modifieLe;

  // Client specific
  final String? adresseParDefaut;
  final double? latDomicile;
  final double? lngDomicile;

  // Prestataire specific
  final String? specialitePrincipale;
  final double? noteMoyenne;
  final bool? estDisponible;
  final bool? estValideKyc;
  final double? latitudeActuelle;
  final double? longitudeActuelle;
  final double? prixHoraire;
  final int? totalMissions;
  final double? tauxAcceptation;
  final double? revenusMois;
  final List<String>? services;
  final bool? isOnline;

  const UserModel({
    required this.id,
    required this.nom,
    required this.prenom,
    this.email,
    required this.telephone,
    this.photoUrl,
    required this.role,
    this.estActif = true,
    this.estBanni = false,
    required this.creeLe,
    this.modifieLe,
    this.adresseParDefaut,
    this.latDomicile,
    this.lngDomicile,
    this.specialitePrincipale,
    this.noteMoyenne,
    this.estDisponible,
    this.estValideKyc,
    this.latitudeActuelle,
    this.longitudeActuelle,
    this.prixHoraire,
    this.totalMissions,
    this.tauxAcceptation,
    this.revenusMois,
    this.services,
    this.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      nom: json['name'] ?? json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'],
      telephone: json['phone'] ?? json['telephone'] ?? '',
      photoUrl: json['photo_url'] ?? json['photoUrl'],
      role: _parseRole(json['type'] ?? json['role'] ?? 'client'),
      estActif: json['est_actif'] ?? json['isActive'] ?? true,
      estBanni: json['est_banni'] ?? false,
      creeLe:
          DateTime.tryParse(json['createdAt'] ?? json['cree_le'] ?? '') ??
          DateTime.now(),
      modifieLe: json['modifie_le'] != null
          ? DateTime.tryParse(json['modifie_le'])
          : null,
      specialitePrincipale: json['job'] ?? json['specialite_principale'],
      noteMoyenne: (json['rating'] ?? json['note_moyenne'] ?? 0).toDouble(),
      estDisponible: json['isAvailable'] ?? json['est_disponible'],
      estValideKyc: json['est_valide_kyc'],
      latitudeActuelle: json['latitude_actuelle']?.toDouble(),
      longitudeActuelle: json['longitude_actuelle']?.toDouble(),
      prixHoraire:
          json['prixHoraire']?.toDouble() ?? json['prix_horaire']?.toDouble(),
      totalMissions: json['totalMissions'] ?? json['total_missions'],
      tauxAcceptation: json['taux_acceptation']?.toDouble(),
      revenusMois: json['revenus_mois']?.toDouble(),
      services: json['services'] != null
          ? List<String>.from(json['services'])
          : null,
      isOnline: json['isOnline'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': nom,
    'prenom': prenom,
    'email': email,
    'telephone': telephone,
    'photo_url': photoUrl,
    'role': role.name,
    'est_actif': estActif,
    'est_banni': estBanni,
    'cree_le': creeLe.toIso8601String(),
    'modifie_le': modifieLe?.toIso8601String(),
    'specialite_principale': specialitePrincipale,
    'note_moyenne': noteMoyenne,
    'est_disponible': estDisponible,
    'prix_horaire': prixHoraire,
    'total_missions': totalMissions,
  };

  String get fullName => '$nom $prenom'.trim();
  String get initials {
    if (nom.isEmpty) return '?';
    return nom[0].toUpperCase() +
        (prenom.isNotEmpty ? prenom[0].toUpperCase() : '');
  }

  bool get isArtisan => role == UserRole.prestataire;
  bool get isClient => role == UserRole.client;
  bool get isAdmin => role == UserRole.admin;

  static UserRole _parseRole(String role) {
    switch (role.toLowerCase()) {
      case 'artisan':
        return UserRole.prestataire;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.client;
    }
  }
}
