import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/buttons.dart';

/// Écran 34 — Paramètres du compte (modifier nom, photo, horaires, prix)
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _nomController = TextEditingController(text: 'Konan');
  final _prenomController = TextEditingController(text: 'Kouamé');
  final _phoneController = TextEditingController(text: '07 12 34 56 78');
  bool _notificationsEnabled = true;
  String _language = 'Français';

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.neonWarmGradient),
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Photo
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.neonBlueGradient,
                            ),
                            child: Center(
                              child: Text(
                                'K',
                                style: GoogleFonts.outfit(
                                  color: AppColors.textOnNeon,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.backgroundSecondary,
                                border: Border.all(
                                  color: AppColors.neonBlue,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit_rounded,
                                color: AppColors.neonBlue,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Info personnelles
                    Text(
                      'INFORMATIONS PERSONNELLES',
                      style: GoogleFonts.outfit(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GlassContainer(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FieldLabel('NOM'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _nomController,
                            style: GoogleFonts.inter(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const _FieldLabel('PRÉNOM'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _prenomController,
                            style: GoogleFonts.inter(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const _FieldLabel('TÉLÉPHONE'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _phoneController,
                            readOnly: true,
                            style: GoogleFonts.inter(
                              color: AppColors.textTertiary,
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration(
                              prefixText: '+225 ',
                              suffixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: AppColors.textTertiary,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Horaires de travail (artisan)
                    Text(
                      'HORAIRES DE TRAVAIL',
                      style: GoogleFonts.outfit(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.backgroundTertiary, width: 1),
                      ),
                      child: Column(
                        children: [
                          _HoraireRow(
                            jour: 'Lundi - Vendredi',
                            heure: '07:00 - 19:00',
                            onTap: () {},
                          ),
                          _HoraireRow(
                            jour: 'Samedi',
                            heure: '08:00 - 16:00',
                            onTap: () {},
                          ),
                          _HoraireRow(
                            jour: 'Dimanche',
                            heure: '09:00 - 13:00',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Grille de prix
                    Text(
                      'GRILLE DE PRIX',
                      style: GoogleFonts.outfit(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.backgroundTertiary, width: 1),
                      ),
                      child: const Column(
                        children: [
                          _PriceRow(service: 'Diagnostic', price: '2 000 FCFA'),
                          _PriceRow(
                            service: 'Fuite simple',
                            price: '5 000 - 8 000 FCFA',
                          ),
                          _PriceRow(
                            service: 'Fuite complexe',
                            price: '10 000 - 20 000 FCFA',
                          ),
                          _PriceRow(
                            service: 'Installation',
                            price: '15 000 - 30 000 FCFA',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Notifications toggle
                    Text(
                      'PRÉFÉRENCES',
                      style: GoogleFonts.outfit(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.backgroundTertiary, width: 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Notifications',
                                style: GoogleFonts.inter(
                                  color: AppColors.textPrimary,
                                  fontSize: 15,
                                ),
                              ),
                              Switch(
                                value: _notificationsEnabled,
                                onChanged: (v) =>
                                    setState(() => _notificationsEnabled = v),
                                activeColor: AppColors.neonBlue,
                              ),
                            ],
                          ),
                          const Divider(color: AppColors.backgroundTertiary, height: 1),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Langue',
                                style: GoogleFonts.inter(
                                  color: AppColors.textPrimary,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(
                                  () => _language = _language == 'Français'
                                      ? 'English'
                                      : 'Français',
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      _language,
                                      style: GoogleFonts.inter(
                                        color: AppColors.neonBlue,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      color: AppColors.textTertiary,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    GoldButton(
                      label: 'SAUVEGARDER',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Profil mis à jour ! (simulation)',
                              style: GoogleFonts.inter(fontSize: 13, color: Colors.white),
                            ),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      isFullWidth: true,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'PARAMÈTRES',
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        color: AppColors.textTertiary,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    );
  }
}

class _HoraireRow extends StatelessWidget {
  final String jour;
  final String heure;
  final VoidCallback onTap;
  const _HoraireRow({
    required this.jour,
    required this.heure,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              jour,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Text(
                  heure,
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.edit_rounded,
                  color: AppColors.textTertiary,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String service;
  final String price;
  const _PriceRow({required this.service, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            service,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.inter(
              color: AppColors.neonPurple,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Écran 35 — Bascule de rôle : Client ↔ Artisan
class RoleSwitchScreen extends StatelessWidget {
  final String currentRole;
  const RoleSwitchScreen({super.key, this.currentRole = 'client'});

  @override
  Widget build(BuildContext context) {
    final isClient = currentRole == 'client';

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.neonWarmGradient),
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
            const SizedBox(height: 40),

            // Current role
            Text(
              'RÔLE ACTUEL',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.neonWarmGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isClient ? Icons.person_rounded : Icons.handyman_rounded,
                    color: AppColors.textOnNeon,
                    size: 32,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    isClient ? 'CLIENT' : 'ARTISAN',
                    style: GoogleFonts.outfit(
                      color: AppColors.textOnNeon,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            const Icon(
              Icons.swap_vert_rounded,
              color: AppColors.textTertiary,
              size: 40,
            ),
            const SizedBox(height: 32),

            // Target role
            Text(
              'BASCULER VERS',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 16),
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isClient ? Icons.handyman_rounded : Icons.person_rounded,
                    color: AppColors.textPrimary,
                    size: 32,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    isClient ? 'ARTISAN' : 'CLIENT',
                    style: GoogleFonts.outfit(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isClient
                  ? 'En mode Artisan, vous recevrez des demandes de missions et pourrez gérer votre activité.'
                  : 'En mode Client, vous pourrez rechercher et contacter des artisans.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const Spacer(),

            GoldButton(
              label: 'CONFIRMER LA BASCULE',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Basculé en mode ${isClient ? "Artisan" : "Client"} ! (simulation)',
                      style: GoogleFonts.inter(fontSize: 13),
                    ),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.pop(context);
              },
              isFullWidth: true,
            ),
            const SizedBox(height: 12),
            GhostButton(
              label: 'Annuler',
              onPressed: () => Navigator.pop(context),
              isFullWidth: true,
            ),
            const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'BASCULE DE RÔLE',
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
