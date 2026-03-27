/// Modèle Mission — conforme UML Barra de Babi
enum MissionStatut {
  enAttente, // EN_ATTENTE
  recherche, // RECHERCHE (broadcast en cours)
  acceptee, // ACCEPTÉE par un artisan
  enCours, // EN_COURS (artisan en route / travail)
  terminee, // TERMINÉE
  annulee, // ANNULÉE
}

class MissionModel {
  final String id;
  final String clientId;
  final String? artisanId;
  final String categorieId;
  final String sousProbleme;
  final MissionStatut statut;
  final double? latClient;
  final double? lngClient;
  final String? adresseClient;
  final double? prixFinal;
  final DateTime creeLe;
  final DateTime? accepteeLe;
  final DateTime? commenceeLe;
  final DateTime? termineeLe;
  final DateTime? annuleeLe;
  final String? artisanNom;
  final double? artisanNote;

  const MissionModel({
    required this.id,
    required this.clientId,
    this.artisanId,
    required this.categorieId,
    required this.sousProbleme,
    required this.statut,
    this.latClient,
    this.lngClient,
    this.adresseClient,
    this.prixFinal,
    required this.creeLe,
    this.accepteeLe,
    this.commenceeLe,
    this.termineeLe,
    this.annuleeLe,
    this.artisanNom,
    this.artisanNote,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'] ?? '',
      clientId: json['client_id'] ?? json['clientId'] ?? '',
      artisanId: json['artisan_id'] ?? json['artisanId'],
      categorieId: json['categorie_id'] ?? json['categorieId'] ?? '',
      sousProbleme: json['sous_probleme'] ?? json['sousProbleme'] ?? '',
      statut: _parseStatut(json['statut'] ?? 'en_attente'),
      latClient: json['lat_client']?.toDouble(),
      lngClient: json['lng_client']?.toDouble(),
      adresseClient: json['adresse_client'],
      prixFinal: json['prix_final']?.toDouble(),
      creeLe: DateTime.tryParse(json['cree_le'] ?? '') ?? DateTime.now(),
      accepteeLe: json['acceptee_le'] != null
          ? DateTime.tryParse(json['acceptee_le'])
          : null,
      commenceeLe: json['commencee_le'] != null
          ? DateTime.tryParse(json['commencee_le'])
          : null,
      termineeLe: json['terminee_le'] != null
          ? DateTime.tryParse(json['terminee_le'])
          : null,
      annuleeLe: json['annulee_le'] != null
          ? DateTime.tryParse(json['annulee_le'])
          : null,
      artisanNom: json['artisan_nom'],
      artisanNote: json['artisan_note']?.toDouble(),
    );
  }

  String get statutLabel {
    switch (statut) {
      case MissionStatut.enAttente:
        return 'En attente';
      case MissionStatut.recherche:
        return 'Recherche artisan...';
      case MissionStatut.acceptee:
        return 'Acceptée';
      case MissionStatut.enCours:
        return 'En cours';
      case MissionStatut.terminee:
        return 'Terminée';
      case MissionStatut.annulee:
        return 'Annulée';
    }
  }

  static MissionStatut _parseStatut(String statut) {
    switch (statut.toLowerCase()) {
      case 'recherche':
        return MissionStatut.recherche;
      case 'acceptee':
        return MissionStatut.acceptee;
      case 'en_cours':
        return MissionStatut.enCours;
      case 'terminee':
        return MissionStatut.terminee;
      case 'annulee':
        return MissionStatut.annulee;
      default:
        return MissionStatut.enAttente;
    }
  }
}
