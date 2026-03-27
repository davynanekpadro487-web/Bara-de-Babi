import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/buttons.dart';
import '../widgets/cards.dart';

/// Écran 26 — Tableau de bord Artisan
class ArtisanDashboardScreen extends StatefulWidget {
  const ArtisanDashboardScreen({super.key});

  @override
  State<ArtisanDashboardScreen> createState() => _ArtisanDashboardScreenState();
}

class _ArtisanDashboardScreenState extends State<ArtisanDashboardScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const _ArtisanHomeContent(),
      const _ArtisanMissionsContent(),
      const _ArtisanStatsContent(),
      const _ArtisanProfileContent(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.neonWarmGradient),
        child: IndexedStack(index: _currentIndex, children: _screens),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.backgroundTertiary, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.dashboard_rounded,
                label: 'ACCUEIL',
                isSelected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _NavItem(
                icon: Icons.work_outline_rounded,
                label: 'MISSIONS',
                isSelected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
              _NavItem(
                icon: Icons.bar_chart_rounded,
                label: 'STATS',
                isSelected: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2),
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                label: 'PROFIL',
                isSelected: _currentIndex == 3,
                onTap: () => setState(() => _currentIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isSelected ? 1.1 : 1.0,
              child: Icon(
                icon,
                size: 24,
                color: isSelected
                    ? AppColors.neonBlue
                    : AppColors.textTertiary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: isSelected
                    ? AppColors.neonBlue
                    : AppColors.textTertiary.withValues(alpha: 0.6),
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// Écran 26 — Dashboard home artisan
// ═══════════════════════════════════════════════════════
class _ArtisanHomeContent extends StatefulWidget {
  const _ArtisanHomeContent();

  @override
  State<_ArtisanHomeContent> createState() => _ArtisanHomeContentState();
}

class _ArtisanHomeContentState extends State<_ArtisanHomeContent> {
  // Écran 27 — Toggle Disponibilité
  bool _isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TABLEAU DE BORD',
                      style: GoogleFonts.outfit(
                        color: AppColors.neonBlue,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bonjour, Soro 👋',
                      style: GoogleFonts.outfit(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.glassBorder,
                      width: 0.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.textPrimary,
                    size: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ═══ Écran 27 — Bouton Disponibilité ON/OFF ═══
            GestureDetector(
              onTap: () => setState(() => _isAvailable = !_isAvailable),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _isAvailable
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isAvailable
                        ? AppColors.success.withValues(alpha: 0.4)
                        : AppColors.error.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    // Animated toggle
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 56,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: _isAvailable
                            ? AppColors.success
                            : AppColors.error.withValues(alpha: 0.5),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 300),
                        alignment: _isAvailable
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 26,
                          height: 26,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isAvailable ? 'DISPONIBLE' : 'INDISPONIBLE',
                            style: GoogleFonts.outfit(
                              color: _isAvailable
                                  ? AppColors.success
                                  : AppColors.error,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isAvailable
                                ? 'Vous recevez les demandes de missions'
                                : 'Vous ne recevez plus de missions',
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Stats du jour
            Text(
              'AUJOURD\'HUI',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'Missions',
                    value: '3',
                    icon: Icons.work_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    label: 'Revenus',
                    value: '24K',
                    icon: Icons.payments_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    label: 'Note',
                    value: '4.8',
                    icon: Icons.star_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Abonnement
            Text(
              'ABONNEMENT',
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
                gradient: AppColors.neonWarmGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_rounded,
                    color: AppColors.textOnNeon,
                    size: 28,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PLAN PRO',
                          style: GoogleFonts.outfit(
                            color: AppColors.textOnNeon,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Expire le 15 Avril 2026',
                          style: GoogleFonts.inter(
                            color: AppColors.textOnNeon.withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.textOnNeon.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'ACTIF',
                      style: GoogleFonts.outfit(
                        color: AppColors.textOnNeon,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Missions du jour
            Text(
              'MISSIONS DU JOUR',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            ..._todayMissions.map((m) => _MissionCard(mission: m)),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _todayMissions = [
    {
      'client': 'Kouamé Jean',
      'problem': 'Fuite de robinet',
      'time': '09:00',
      'status': 'Terminée',
      'price': '8 500',
    },
    {
      'client': 'Bamba Awa',
      'problem': 'Toilette bouchée',
      'time': '11:30',
      'status': 'Terminée',
      'price': '6 000',
    },
    {
      'client': 'Traoré Ali',
      'problem': 'Installation douche',
      'time': '15:00',
      'status': 'En cours',
      'price': '15 000',
    },
  ];
}

class _MissionCard extends StatelessWidget {
  final Map<String, dynamic> mission;
  const _MissionCard({required this.mission});

  @override
  Widget build(BuildContext context) {
    final isActive = mission['status'] == 'En cours';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.neonPurple.withValues(alpha: 0.05)
            : AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive
              ? AppColors.neonPurple.withValues(alpha: 0.3)
              : AppColors.glassBorder,
          width: isActive ? 1 : 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neonPurple.withValues(alpha: 0.1),
            ),
            child: Center(
              child: Text(
                (mission['client'] as String)[0],
                style: GoogleFonts.outfit(
                  color: AppColors.neonPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission['client'] as String,
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  mission['problem'] as String,
                  style: GoogleFonts.inter(
                    color: AppColors.textTertiary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${mission['price']} F',
                style: GoogleFonts.outfit(
                  color: AppColors.neonPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                mission['time'] as String,
                style: GoogleFonts.inter(
                  color: AppColors.textTertiary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// Écran 28 — Notification mission reçue (popup simulé)
// Écran 29 — Détail mission acceptée
// ═══════════════════════════════════════════════════════
class _ArtisanMissionsContent extends StatelessWidget {
  const _ArtisanMissionsContent();

  static const List<Map<String, dynamic>> _pendingMissions = [
    {
      'client': 'Diabaté Moussa',
      'problem': 'Fuite chauffe-eau',
      'distance': '1.2 km',
      'price': '10 000 - 15 000',
      'urgent': true,
    },
  ];

  static const List<Map<String, dynamic>> _activeMissions = [
    {
      'client': 'Traoré Ali',
      'problem': 'Installation douche',
      'address': 'Cocody Angré, Star 8',
      'price': '15 000',
      'time': '15:00',
    },
  ];

  static const List<Map<String, dynamic>> _completedMissions = [
    {
      'client': 'Kouamé Jean',
      'problem': 'Fuite de robinet',
      'price': '8 500',
      'date': '09 Mar',
    },
    {
      'client': 'Bamba Awa',
      'problem': 'Toilette bouchée',
      'price': '6 000',
      'date': '09 Mar',
    },
    {
      'client': 'Koné Fatou',
      'problem': 'Robinet cassé',
      'price': '7 500',
      'date': '08 Mar',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MES MISSIONS',
              style: GoogleFonts.outfit(
                color: AppColors.neonPurple,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Gestion',
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),

            // Pending (Écran 28)
            if (_pendingMissions.isNotEmpty) ...[
              Text(
                'NOUVELLES DEMANDES',
                style: GoogleFonts.outfit(
                  color: AppColors.warning,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              ..._pendingMissions.map((m) => _IncomingMissionCard(mission: m)),
              const SizedBox(height: 24),
            ],

            // Active (Écran 29)
            Text(
              'EN COURS',
              style: GoogleFonts.outfit(
                color: AppColors.success,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            ..._activeMissions.map((m) => _ActiveMissionCard(mission: m)),
            const SizedBox(height: 24),

            // Completed
            Text(
              'TERMINÉES',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            ..._completedMissions.map((m) => _CompletedMissionCard(mission: m)),
          ],
        ),
      ),
    );
  }
}

/// Écran 28 — Pop-up mission reçue : Accepter ou Refuser
class _IncomingMissionCard extends StatelessWidget {
  final Map<String, dynamic> mission;
  const _IncomingMissionCard({required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.warning.withValues(alpha: 0.08),
            AppColors.backgroundCard,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '🔔 NOUVELLE MISSION',
                  style: GoogleFonts.outfit(
                    color: AppColors.warning,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(),
              if (mission['urgent'] == true)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'URGENT',
                    style: GoogleFonts.outfit(
                      color: AppColors.error,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            mission['client'] as String,
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            mission['problem'] as String,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.textTertiary,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                mission['distance'] as String,
                style: GoogleFonts.inter(
                  color: AppColors.textTertiary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.payments_outlined,
                color: AppColors.textTertiary,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${mission['price']} FCFA',
                style: GoogleFonts.inter(
                  color: AppColors.neonPurple,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GhostButton(
                  label: 'REFUSER',
                  onPressed: () {},
                  borderColor: AppColors.error.withValues(alpha: 0.5),
                  textColor: AppColors.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GoldButton(label: 'ACCEPTER', onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Écran 29 — Détail mission acceptée
class _ActiveMissionCard extends StatelessWidget {
  final Map<String, dynamic> mission;
  const _ActiveMissionCard({required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'EN COURS',
                style: GoogleFonts.outfit(
                  color: AppColors.success,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            mission['client'] as String,
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            mission['problem'] as String,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.textTertiary,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                mission['address'] as String,
                style: GoogleFonts.inter(
                  color: AppColors.textTertiary,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '${mission['price']} F',
                style: GoogleFonts.outfit(
                  color: AppColors.neonPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Écran 30 — Nav carte + Écran 31 — Terminer
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.map_rounded, size: 16),
                  label: const Text('NAVIGUER'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Mission terminée ! (simulation)',
                          style: GoogleFonts.inter(fontSize: 13),
                        ),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_rounded, size: 16),
                  label: const Text('TERMINER'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompletedMissionCard extends StatelessWidget {
  final Map<String, dynamic> mission;
  const _CompletedMissionCard({required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.glassBorder, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission['client'] as String,
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  mission['problem'] as String,
                  style: GoogleFonts.inter(
                    color: AppColors.textTertiary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${mission['price']} F',
                style: GoogleFonts.outfit(
                  color: AppColors.neonPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                mission['date'] as String,
                style: GoogleFonts.inter(
                  color: AppColors.textTertiary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// Écran 32 — Historique + statistiques artisan
// ═══════════════════════════════════════════════════════
class _ArtisanStatsContent extends StatelessWidget {
  const _ArtisanStatsContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PERFORMANCES',
              style: GoogleFonts.outfit(
                color: AppColors.neonPurple,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Statistiques',
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),

            // Period selector
            Row(
              children: [
                _PeriodChip(label: 'Semaine', isSelected: false),
                const SizedBox(width: 8),
                _PeriodChip(label: 'Mois', isSelected: true),
                const SizedBox(width: 8),
                _PeriodChip(label: 'Année', isSelected: false),
              ],
            ),
            const SizedBox(height: 24),

            // Revenue
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REVENUS DU MOIS',
                    style: GoogleFonts.outfit(
                      color: AppColors.textTertiary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '187 500 FCFA',
                    style: GoogleFonts.outfit(
                      color: AppColors.neonPurple,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_up_rounded,
                        color: AppColors.success,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '+12% vs mois dernier',
                        style: GoogleFonts.inter(
                          color: AppColors.success,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Stats grid
            Row(
              children: [
                Expanded(
                  child: _StatBox(label: 'Missions\nterminées', value: '23'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatBox(label: 'Taux\nacceptation', value: '94%'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatBox(label: 'Note\nmoyenne', value: '4.8'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatBox(label: 'Temps de\nréponse', value: '45s'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Simulated bar chart
            Text(
              'MISSIONS PAR JOUR',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 160,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.glassBorder, width: 0.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _BarChart(label: 'Lun', value: 0.6),
                  _BarChart(label: 'Mar', value: 0.8),
                  _BarChart(label: 'Mer', value: 0.4),
                  _BarChart(label: 'Jeu', value: 0.9),
                  _BarChart(label: 'Ven', value: 1.0),
                  _BarChart(label: 'Sam', value: 0.7),
                  _BarChart(label: 'Dim', value: 0.3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _PeriodChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.neonPurple.withValues(alpha: 0.12)
            : AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.neonPurple : AppColors.glassBorder,
          width: isSelected ? 1.5 : 0.5,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: isSelected ? AppColors.neonPurple : AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.glassBorder, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppColors.textTertiary,
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final String label;
  final double value;
  const _BarChart({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 80 * value,
              decoration: BoxDecoration(
                gradient: AppColors.neonWarmGradient,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: AppColors.textTertiary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// Écran Profil artisan (dans dashboard)
// ═══════════════════════════════════════════════════════
class _ArtisanProfileContent extends StatelessWidget {
  const _ArtisanProfileContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MON PROFIL',
              style: GoogleFonts.outfit(
                color: AppColors.neonPurple,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Artisan',
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),

            // Profile card
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.neonBlueGradient,
                    ),
                    child: Center(
                      child: Text(
                        'S',
                        style: GoogleFonts.outfit(
                          color: AppColors.textOnNeon,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Soro Ibrahim',
                    style: GoogleFonts.outfit(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'PLOMBIER',
                    style: GoogleFonts.outfit(
                      color: AppColors.neonPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.neonPurple,
                        size: 18,
                      ),
                      Text(
                        ' 4.8',
                        style: GoogleFonts.outfit(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        ' (127 avis)',
                        style: GoogleFonts.inter(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'KYC VÉRIFIÉ ✓',
                      style: GoogleFonts.outfit(
                        color: AppColors.success,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings
            _SettingsItem(
              icon: Icons.person_outline_rounded,
              label: 'Modifier le profil',
              onTap: () {},
            ),
            _SettingsItem(
              icon: Icons.schedule_rounded,
              label: 'Horaires de travail',
              onTap: () {},
            ),
            _SettingsItem(
              icon: Icons.payments_outlined,
              label: 'Grille de prix',
              onTap: () {},
            ),
            _SettingsItem(
              icon: Icons.card_membership_rounded,
              label: 'Mon abonnement',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
              ),
              accent: true,
            ),
            _SettingsItem(
              icon: Icons.swap_horiz_rounded,
              label: 'Basculer en mode Client',
              onTap: () {},
              accent: true,
            ),
            _SettingsItem(
              icon: Icons.help_outline_rounded,
              label: 'FAQ & Support',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FaqSupportScreen()),
                );
              },
            ),
            _SettingsItem(
              icon: Icons.info_outline_rounded,
              label: 'À propos',
              trailing: 'v2.0.0',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            GhostButton(
              label: 'Déconnexion',
              icon: Icons.logout_rounded,
              isFullWidth: true,
              borderColor: AppColors.error.withValues(alpha: 0.5),
              textColor: AppColors.error,
              onPressed: () {},
            ),
          ],
        ),
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
  const _SettingsItem({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
    this.accent = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.glassBorder, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: accent ? AppColors.neonPurple : AppColors.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: accent ? AppColors.neonPurple : AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: accent ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: GoogleFonts.inter(
                  color: AppColors.textTertiary,
                  fontSize: 13,
                ),
              ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// Écran 33 — Gestion abonnement
// ═══════════════════════════════════════════════════════
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectedPlan = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'ABONNEMENT',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current plan
            GlassContainer(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.neonBlueGradient,
                    ),
                    child: const Icon(
                      Icons.verified_rounded,
                      color: AppColors.textOnNeon,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PLAN PRO ACTUEL',
                          style: GoogleFonts.outfit(
                            color: AppColors.neonPurple,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Expire le 15 Avril 2026',
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'ACTIF',
                      style: GoogleFonts.outfit(
                        color: AppColors.success,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            Text(
              'CHOISIR UN PLAN',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),

            // Plans
            _PlanCard(
              name: 'STARTER',
              price: '2 000',
              period: '/mois',
              features: [
                '5 missions / jour',
                'Profil basique',
                'Support standard',
              ],
              isSelected: _selectedPlan == 0,
              onTap: () => setState(() => _selectedPlan = 0),
            ),
            _PlanCard(
              name: 'PRO',
              price: '5 000',
              period: '/mois',
              features: [
                'Missions illimitées',
                'Profil vérifié ✓',
                'Support prioritaire',
                'Statistiques avancées',
              ],
              isSelected: _selectedPlan == 1,
              isPopular: true,
              onTap: () => setState(() => _selectedPlan = 1),
            ),
            _PlanCard(
              name: 'PREMIUM',
              price: '10 000',
              period: '/mois',
              features: [
                'Tout du Pro',
                'Badge Premium ⭐',
                'Priorité dans les résultats',
                'Support 24/7',
              ],
              isSelected: _selectedPlan == 2,
              onTap: () => setState(() => _selectedPlan = 2),
            ),
            const SizedBox(height: 24),

            Text(
              'MÉTHODE DE PAIEMENT',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _PaymentMethod(
                    label: 'Wave CI',
                    icon: '🌊',
                    isSelected: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _PaymentMethod(
                    label: 'Orange Money',
                    icon: '🍊',
                    isSelected: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            GoldButton(
              label: 'PAYER MAINTENANT',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Paiement simulé avec succès !',
                      style: GoogleFonts.inter(fontSize: 13),
                    ),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool isSelected;
  final bool isPopular;
  final VoidCallback onTap;

  const _PlanCard({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    required this.isSelected,
    this.isPopular = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.neonPurple.withValues(alpha: 0.05)
              : AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.neonPurple : AppColors.glassBorder,
            width: isSelected ? 2 : 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    color: isSelected
                        ? AppColors.neonPurple
                        : AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                if (isPopular) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.neonWarmGradient,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'POPULAIRE',
                      style: GoogleFonts.outfit(
                        color: AppColors.textOnNeon,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  price,
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  ' FCFA$period',
                  style: GoogleFonts.inter(
                    color: AppColors.textTertiary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_rounded,
                      color: AppColors.neonPurple,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      f,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethod extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  const _PaymentMethod({
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.neonPurple.withValues(alpha: 0.08)
            : AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.neonPurple : AppColors.glassBorder,
          width: isSelected ? 1.5 : 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: isSelected ? AppColors.neonPurple : AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// Écran 36 — FAQ & Support
// ═══════════════════════════════════════════════════════
class FaqSupportScreen extends StatelessWidget {
  const FaqSupportScreen({super.key});

  static const List<Map<String, String>> _faqs = [
    {
      'q': 'Comment fonctionne Barra de Babi ?',
      'a':
          'Vous décrivez votre problème, notre algorithme trouve l\'artisan vérifié le plus proche, et il arrive chez vous.',
    },
    {
      'q': 'Comment devenir artisan ?',
      'a':
          'Inscrivez-vous, uploadez votre carte d\'identité et sélectionnez votre spécialité. Après validation KYC (24-48h), vous pourrez recevoir des missions.',
    },
    {
      'q': 'Quels sont les modes de paiement ?',
      'a':
          'Les artisans paient leur abonnement via Wave CI ou Orange Money. Le paiement client-artisan se fait directement.',
    },
    {
      'q': 'Comment annuler une mission ?',
      'a':
          'Vous pouvez annuler une mission en cours depuis l\'écran de suivi. Des frais peuvent s\'appliquer si l\'artisan est déjà en route.',
    },
    {
      'q': 'Mon compte artisan est suspendu, que faire ?',
      'a':
          'Votre compte est suspendu si votre abonnement a expiré. Renouvelez-le depuis la section Abonnement pour réactiver votre compte.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'FAQ & SUPPORT',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUESTIONS FRÉQUENTES',
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            ..._faqs.map(
              (faq) => _FaqItem(question: faq['q']!, answer: faq['a']!),
            ),
            const SizedBox(height: 32),

            Text(
              'NOUS CONTACTER',
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
                children: [
                  TextField(
                    maxLines: 4,
                    style: GoogleFonts.inter(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Décrivez votre problème...',
                      hintStyle: GoogleFonts.inter(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GoldButton(
                    label: 'ENVOYER',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Message envoyé ! (simulation)',
                            style: GoogleFonts.inter(fontSize: 13),
                          ),
                          backgroundColor: AppColors.success,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _isExpanded
              ? AppColors.neonPurple.withValues(alpha: 0.05)
              : AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isExpanded
                ? AppColors.neonPurple.withValues(alpha: 0.3)
                : AppColors.glassBorder,
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: GoogleFonts.outfit(
                      color: _isExpanded
                          ? AppColors.neonPurple
                          : AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 12),
              Text(
                widget.answer,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
