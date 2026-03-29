import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../widgets/cards.dart';
import '../widgets/glass_container.dart';
import '../widgets/premium_background.dart';
import 'artisan_directory_screen.dart';
import 'service_request_screen.dart';
import 'chat_list_screen.dart';
import 'profile_screen.dart';

/// Client Home Screen — Warm & Welcoming Theme
class ClientHomeScreen extends StatefulWidget {
  final String userRole;
  const ClientHomeScreen({super.key, this.userRole = 'client'});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _screens = [
      const _HomeContent(),
      const ArtisanDirectoryScreen(),
      const ChatListScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              physics: const BouncingScrollPhysics(),
              children: _screens,
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      bottom: 24,
      left: 24,
      right: 24,
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        borderRadius: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: 'Accueil',
              isSelected: _currentIndex == 0,
              onTap: () => _onNavTap(0),
            ),
            _NavItem(
              icon: Icons.search_rounded,
              label: 'Prestataires',
              isSelected: _currentIndex == 1,
              onTap: () => _onNavTap(1),
            ),
            _NavItem(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'Messages',
              isSelected: _currentIndex == 2,
              onTap: () => _onNavTap(2),
            ),
            _NavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profil',
              isSelected: _currentIndex == 3,
              onTap: () => _onNavTap(3),
            ),
          ],
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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ] : null,
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? Colors.white : AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: isSelected ? AppColors.primary : AppColors.textTertiary,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: _HeaderSection()),
        SliverToBoxAdapter(child: _SearchBarSection()),
        SliverToBoxAdapter(child: _PromoBannerSection()),
        SliverToBoxAdapter(child: _CategoriesSection()),
        SliverToBoxAdapter(child: _PopularArtisansSection()),
        const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.pastelMint,
                        child: const Text('👋', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Salut 👋',
                          style: GoogleFonts.outfit(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Abidjan, CIV',
                          style: GoogleFonts.outfit(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GlassContainer(
                  padding: const EdgeInsets.all(12),
                  borderRadius: 100,
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.textPrimary,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            RichText(
              text: TextSpan(
                style: GoogleFonts.outfit(
                  color: AppColors.textPrimary,
                  fontSize: 34,
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
                children: [
                  const TextSpan(text: 'Trouvez vos\n'),
                  TextSpan(
                    text: 'services à domicile',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                      shadows: [
                        Shadow(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
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

class _SearchBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: GlassContainer(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              borderRadius: 100,
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: AppColors.primary, size: 26),
                  const SizedBox(width: 14),
                  Text(
                    'Rechercher un service...',
                    style: GoogleFonts.inter(
                      color: AppColors.textTertiary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          GlassContainer(
            width: 58,
            height: 58,
            borderRadius: 100,
            gradient: AppColors.primaryGradient,
            padding: EdgeInsets.zero,
            child: const Center(
              child: Icon(Icons.tune_rounded, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoBannerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.pastelMint,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.pastelMint.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -30,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.accentLime,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '-30%',
                    style: GoogleFonts.outfit(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Service de Nettoyage\nProfessionnel',
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Réservez pour la réduction',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nos Services',
                style: GoogleFonts.outfit(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Tout voir',
                style: GoogleFonts.outfit(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: AppConstants.serviceCategories.length,
            itemBuilder: (context, index) {
              final cat = AppConstants.serviceCategories[index];
              
              Color getCategoryColor(String name) {
                switch (name) {
                  case 'blue': return AppColors.pastelSkyBlue;
                  case 'pink': return AppColors.pastelPink;
                  case 'yellow': return AppColors.pastelPeach;
                  case 'orange': return AppColors.pastelPeach;
                  case 'green': return AppColors.pastelMint;
                  case 'purple': return AppColors.pastelLavender;
                  default: return AppColors.pastelSkyBlue;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CategoryCard(
                  emoji: cat['icon'] as String,
                  title: cat['name'] as String,
                  subtitle: cat['description'] as String,
                  color: getCategoryColor(cat['colorName'] ?? 'blue'),
                  isSelected: index == 0,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ServiceRequestScreen(
                          preselectedCategory: cat['id'] as String,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PopularArtisansSection extends StatelessWidget {
  static const List<Map<String, dynamic>> _mockArtisans = [
    {
      'name': 'Soro Ibrahim',
      'specialty': 'Plombier',
      'rating': 4.8,
      'missions': 127,
      'available': true,
    },
    {
      'name': 'Kouadio Akissi',
      'specialty': 'Couturière',
      'rating': 4.9,
      'missions': 89,
      'available': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Meilleurs Prestataires',
                style: GoogleFonts.outfit(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Tout voir',
                style: GoogleFonts.outfit(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ..._mockArtisans.map(
            (prestataire) => ArtisanCard(
              name: prestataire['name'] as String,
              specialty: prestataire['specialty'] as String,
              rating: (prestataire['rating'] as num).toDouble(),
              missions: prestataire['missions'] as int,
              isAvailable: prestataire['available'] as bool,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
