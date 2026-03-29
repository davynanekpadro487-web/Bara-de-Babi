import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/buttons.dart';
import '../widgets/glass_container.dart';
import '../widgets/premium_background.dart';
import 'client_home_screen.dart';
import 'artisan_dashboard_screen.dart';

/// Screen 08 — Profile Creation (Name, Photo)
class ProfileCreationScreen extends StatefulWidget {
  final String role; // 'client' or 'artisan'
  const ProfileCreationScreen({super.key, required this.role});

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  bool _photoSelected = false;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    super.dispose();
  }

  void _pickPhoto() {
    setState(() => _photoSelected = true);
  }

  void _continuer() {
    if (_nomController.text.isEmpty || _prenomController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Veuillez remplir tous les champs',
            style: GoogleFonts.inter(fontSize: 13, color: Colors.white),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (widget.role == 'artisan') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const KycUploadScreen()),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const _WelcomeReadyScreen(role: 'client'),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
              ),
              const SizedBox(height: 20),
              Text(
                'ÉTAPE 1',
                style: GoogleFonts.outfit(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Informations\npersonnelles',
                style: GoogleFonts.outfit(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 3,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 40),

              // Photo picker
              Center(
                child: GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: _photoSelected
                                ? AppColors.primary
                                : AppColors.backgroundSecondary,
                            width: _photoSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: _photoSelected
                              ? Text(
                                  'KK',
                                  style: GoogleFonts.outfit(
                                    color: AppColors.primary,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              : const Icon(
                                  Icons.camera_alt_rounded,
                                  color: AppColors.textTertiary,
                                  size: 36,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  _photoSelected ? 'Photo sélectionnée' : 'Ajouter une photo',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Form
              GlassContainer(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NOM',
                      style: GoogleFonts.outfit(
                        color: AppColors.textSecondary, // Rendu un peu plus lisible (moins pale)
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                      ),
                      child: TextField(
                        controller: _nomController,
                        style: GoogleFonts.inter(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Votre nom de famille',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'PRÉNOM',
                      style: GoogleFonts.outfit(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                      ),
                      child: TextField(
                        controller: _prenomController,
                        style: GoogleFonts.inter(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Votre prénom',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              PrimaryButton(
                label: 'CONTINUER',
                onPressed: _continuer,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Screen 09-11 — KYC Prestataire: Upload CIN + Choice Specialist
class KycUploadScreen extends StatefulWidget {
  const KycUploadScreen({super.key});

  @override
  State<KycUploadScreen> createState() => _KycUploadScreenState();
}

class _KycUploadScreenState extends State<KycUploadScreen> {
  int _step = 0; // 0: recto, 1: verso, 2: specialty
  bool _rectoUploaded = false;
  bool _versoUploaded = false;
  String? _selectedSpecialty;

  static const List<Map<String, String>> _specialties = [
    {'id': 'plombier', 'label': 'Plombier', 'icon': '🔧'},
    {'id': 'electricien', 'label': 'Électricien', 'icon': '⚡'},
    {'id': 'menuisier', 'label': 'Menuisier', 'icon': '🪚'},
    {'id': 'couturiere', 'label': 'Couturière', 'icon': '🧵'},
    {'id': 'mecanicien', 'label': 'Mécanicien', 'icon': '🔩'},
    {'id': 'coiffeuse', 'label': 'Coiffeuse', 'icon': '💇'},
    {'id': 'peintre', 'label': 'Peintre', 'icon': '🎨'},
    {'id': 'macon', 'label': 'Maçon', 'icon': '🧱'},
  ];

  void _uploadRecto() {
    setState(() {
      _rectoUploaded = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _step = 1);
    });
  }

  void _uploadVerso() {
    setState(() {
      _versoUploaded = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _step = 2);
    });
  }

  void _submit() {
    if (_selectedSpecialty == null) return;
    // [AUTOMATIC VALIDATION] As requested by user, we bypass the pending screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const _WelcomeReadyScreen(role: 'artisan')),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
                    ),
                    Expanded(
                      child: Text(
                        'VÉRIFICATION KYC',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _step == 0
                    ? _buildUploadStep(
                        'RECTO',
                        'Photo de votre carte d\'identité — RECTO',
                        _rectoUploaded,
                        _uploadRecto,
                      )
                    : _step == 1
                    ? _buildUploadStep(
                        'VERSO',
                        'Photo de votre carte d\'identité — VERSO',
                        _versoUploaded,
                        _uploadVerso,
                      )
                    : _buildSpecialtyStep(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadStep(String label, String description, bool uploaded, VoidCallback onUpload) {
    return SingleChildScrollView(
      key: ValueKey(label),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ÉTAPE ${_step + 2} / 4',
            style: GoogleFonts.outfit(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Carte d\'identité\n$label',
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 48),

          // Upload zone
          GestureDetector(
            onTap: onUpload,
            child: Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: uploaded ? AppColors.success.withValues(alpha: 0.1) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: uploaded ? AppColors.success : AppColors.backgroundSecondary,
                  width: uploaded ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    uploaded ? Icons.check_circle_rounded : Icons.cloud_upload_rounded,
                    color: uploaded ? AppColors.success : AppColors.primary,
                    size: 56,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    uploaded ? 'Photo uploadée ✓' : 'Prendre une photo',
                    style: GoogleFonts.outfit(
                      color: uploaded ? AppColors.success : AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Formats : JPG, PNG — Max 5 Mo',
                    style: GoogleFonts.inter(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyStep() {
    return SingleChildScrollView(
      key: const ValueKey('specialty'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ÉTAPE 4 / 4',
            style: GoogleFonts.outfit(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Votre\nspécialité',
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),

          ..._specialties.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => setState(() => _selectedSpecialty = s['id']),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _selectedSpecialty == s['id'] ? AppColors.primary.withValues(alpha: 0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedSpecialty == s['id'] ? AppColors.primary : AppColors.backgroundSecondary,
                      width: _selectedSpecialty == s['id'] ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundSecondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(s['icon']!, style: const TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        s['label']!,
                        style: GoogleFonts.outfit(
                          color: AppColors.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      if (_selectedSpecialty == s['id'])
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          PrimaryButton(
            label: 'SOUMETTRE MON DOSSIER',
            onPressed: _selectedSpecialty != null ? _submit : null,
            isFullWidth: true,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// Écran 12 — Attente validation KYC (Conservé mais bypassé par défaut pour demo)
class KycPendingScreen extends StatelessWidget {
  const KycPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.warning.withValues(alpha: 0.1),
                    border: Border.all(
                      color: AppColors.warning.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(Icons.hourglass_top_rounded, color: AppColors.warning, size: 56),
                ),
                const SizedBox(height: 32),
                Text(
                  'DOSSIER EN COURS\nDE VALIDATION',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Notre équipe examine votre dossier KYC.\nVous recevrez un SMS dès que votre compte\nsera activé.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Écran intermédiaire — Bienvenue (après profil créé)
class _WelcomeReadyScreen extends StatelessWidget {
  final String role;
  const _WelcomeReadyScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success.withValues(alpha: 0.1),
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(Icons.check_rounded, color: AppColors.success, size: 50),
                ),
                const SizedBox(height: 28),
                Text(
                  'BIENVENUE !',
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  role == 'client' 
                    ? 'Votre compte a été créé avec succès.\nCommencez à trouver des prestataires !'
                    : 'Votre compte prestataire a été validé !\nCommencez à recevoir des demandes.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 48),
                PrimaryButton(
                  label: 'C\'EST PARTI !',
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => role == 'client'
                          ? ClientHomeScreen(userRole: role)
                          : const ArtisanDashboardScreen(),
                    ),
                    (route) => false,
                  ),
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
