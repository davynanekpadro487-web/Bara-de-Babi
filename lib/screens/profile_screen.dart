import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/buttons.dart';

/// Profile Screen — User profile + settings with Warm Theme
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.neonWarmGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MON PROFIL',
                style: GoogleFonts.outfit(
                  color: AppColors.neonBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Paramètres',
                style: GoogleFonts.outfit(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 32),

              // Profile card
              GlassContainer(
                padding: const EdgeInsets.all(24),
                borderRadius: 24,
                borderColor: AppColors.backgroundTertiary,
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xFFFCFAF7)],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.neonBlueGradient,
                      ),
                      child: Center(
                        child: Text(
                          'K',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Konan Kouamé',
                            style: GoogleFonts.outfit(
                              color: AppColors.textPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '+225 07 12 34 56 78',
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.neonBlue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'CLIENT PREMIUM',
                              style: GoogleFonts.outfit(
                                color: AppColors.neonBlue,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_note_rounded, color: AppColors.neonBlue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Missions stats
              Text(
                'STATISTIQUES',
                style: GoogleFonts.outfit(
                  color: AppColors.textTertiary,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    child: _MiniStat(
                      value: '12',
                      label: 'Missions',
                      icon: Icons.work_outline_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: _MiniStat(
                      value: '5',
                      label: 'Favoris',
                      icon: Icons.favorite_outline_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MiniStat(
                      value: '4.9',
                      label: 'Note',
                      icon: Icons.star_outline_rounded,
                      color: AppColors.neonBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Settings sections
              Text(
                'MENU',
                style: GoogleFonts.outfit(
                  color: AppColors.textTertiary,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.backgroundTertiary),
                ),
                child: Column(
                  children: [
                    _SettingsItem(
                      icon: Icons.history_rounded,
                      label: 'Historique des missions',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const _MissionHistoryScreen(),
                          ),
                        );
                      },
                    ),
                    _SettingsItem(
                      icon: Icons.swap_horiz_rounded,
                      label: 'Devenir Artisan',
                      onTap: () {},
                      accent: true,
                    ),
                    _SettingsItem(
                      icon: Icons.notifications_none_rounded,
                      label: 'Notifications',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.security_rounded,
                      label: 'Sécurité',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.help_outline_rounded,
                      label: 'Centre d\'aide',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.info_outline_rounded,
                      label: 'À propos',
                      trailing: 'v2.1.0',
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Logout
              GhostButton(
                label: 'Déconnexion',
                icon: Icons.logout_rounded,
                isFullWidth: true,
                textColor: AppColors.error,
                borderColor: AppColors.error.withValues(alpha: 0.2),
                onPressed: () {},
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color? color;

  const _MiniStat({
    required this.value,
    required this.label,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.backgroundTertiary),
      ),
      child: Column(
        children: [
          Icon(icon, color: color ?? AppColors.neonBlue, size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppColors.textTertiary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  final VoidCallback? onTap;
  final bool accent;
  final bool isLast;

  const _SettingsItem({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
    this.accent = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          border: isLast ? null : Border(
            bottom: BorderSide(color: AppColors.backgroundTertiary, width: 0.8),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accent ? AppColors.neonBlue.withValues(alpha: 0.1) : AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: accent ? AppColors.neonBlue : AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: accent ? AppColors.neonBlue : AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: accent ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: GoogleFonts.inter(
                  color: AppColors.textTertiary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary.withValues(alpha: 0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _MissionHistoryScreen extends StatelessWidget {
  const _MissionHistoryScreen();

  static const List<Map<String, dynamic>> _missions = [
    {
      'service': 'Plomberie',
      'problem': 'Fuite de robinet cuisine',
      'artisan': 'Soro Ibrahim',
      'date': '09 Mar 2026',
      'status': 'Terminée',
      'price': '8 500 FCFA',
    },
    {
      'service': 'Couture',
      'problem': 'Confection robe gala',
      'artisan': 'Kouadio Akissi',
      'date': '05 Mar 2026',
      'status': 'Terminée',
      'price': '25 000 FCFA',
    },
    {
      'service': 'Électricité',
      'problem': 'Panne tableau électrique',
      'artisan': 'Koné Moussa',
      'date': '28 Fév 2026',
      'status': 'Terminée',
      'price': '12 000 FCFA',
    },
    {
      'service': 'Menuiserie',
      'problem': 'Réparation porte entrée',
      'artisan': 'Traoré Lassina',
      'date': '20 Fév 2026',
      'status': 'Annulée',
      'price': '—',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HISTORIQUE',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.neonWarmGradient),
        child: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: _missions.length,
          itemBuilder: (context, index) {
            final m = _missions[index];
            final isCancelled = m['status'] == 'Annulée';
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.backgroundTertiary),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (m['service'] as String).toUpperCase(),
                        style: GoogleFonts.outfit(
                          color: AppColors.neonBlue,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isCancelled
                              ? AppColors.error.withValues(alpha: 0.1)
                              : AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          m['status'] as String,
                          style: GoogleFonts.outfit(
                            color: isCancelled ? AppColors.error : AppColors.success,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    m['problem'] as String,
                    style: GoogleFonts.outfit(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.person_outline_rounded, color: AppColors.textTertiary, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        m['artisan'] as String,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        m['price'] as String,
                        style: GoogleFonts.outfit(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Text(
                    m['date'] as String,
                    style: GoogleFonts.inter(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
