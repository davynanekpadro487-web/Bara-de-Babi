import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/cards.dart';
import '../widgets/buttons.dart';
import '../widgets/glass_container.dart';
import '../widgets/premium_background.dart';

/// Prestataire Directory — Search + Filters with Warm Theme
class ArtisanDirectoryScreen extends StatefulWidget {
  const ArtisanDirectoryScreen({super.key});

  @override
  State<ArtisanDirectoryScreen> createState() => _ArtisanDirectoryScreenState();
}

class _ArtisanDirectoryScreenState extends State<ArtisanDirectoryScreen> {
  String _selectedCategory = 'all';
  final _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<Map<String, dynamic>> _allArtisans = [
    {
      'name': 'Soro Ibrahim',
      'specialty': 'Plombier',
      'cat': 'plomberie',
      'rating': 4.8,
      'missions': 127,
      'available': true,
    },
    {
      'name': 'Kouamé Jean',
      'specialty': 'Plombier',
      'cat': 'plomberie',
      'rating': 4.5,
      'missions': 84,
      'available': true,
    },
    {
      'name': 'Koné Moussa',
      'specialty': 'Électricien',
      'cat': 'electricite',
      'rating': 4.9,
      'missions': 203,
      'available': true,
    },
    {
      'name': 'Bamba Sékou',
      'specialty': 'Électricien',
      'cat': 'electricite',
      'rating': 4.6,
      'missions': 156,
      'available': false,
    },
    {
      'name': 'Traoré Lassina',
      'specialty': 'Menuisier',
      'cat': 'menuiserie',
      'rating': 4.7,
      'missions': 95,
      'available': true,
    },
    {
      'name': 'Kouadio Akissi',
      'specialty': 'Couturière',
      'cat': 'couture',
      'rating': 4.9,
      'missions': 89,
      'available': true,
    },
    {
      'name': 'Diallo Fatou',
      'specialty': 'Couturière',
      'cat': 'couture',
      'rating': 4.4,
      'missions': 62,
      'available': true,
    },
    {
      'name': 'Yao Konan',
      'specialty': 'Mécanicien',
      'cat': 'mecanique',
      'rating': 4.7,
      'missions': 178,
      'available': false,
    },
    {
      'name': 'Ouattara Awa',
      'specialty': 'Coiffeuse',
      'cat': 'coiffure',
      'rating': 4.8,
      'missions': 210,
      'available': true,
    },
    {
      'name': 'Koffi Roger',
      'specialty': 'Peintre',
      'cat': 'peinture',
      'rating': 4.3,
      'missions': 45,
      'available': true,
    },
    {
      'name': 'Diabaté Adama',
      'specialty': 'Maçon',
      'cat': 'maconnerie',
      'rating': 4.6,
      'missions': 112,
      'available': true,
    },
  ];

  static const List<Map<String, String>> _categories = [
    {'id': 'all', 'label': 'TOUS', 'icon': '🔥'},
    {'id': 'plomberie', 'label': 'PLOMBERIE', 'icon': '🔧'},
    {'id': 'electricite', 'label': 'ÉLECTRICITÉ', 'icon': '⚡'},
    {'id': 'menuiserie', 'label': 'MENUISERIE', 'icon': '🪚'},
    {'id': 'couture', 'label': 'COUTURE', 'icon': '🧵'},
    {'id': 'mecanique', 'label': 'MÉCANIQUE', 'icon': '🔩'},
    {'id': 'coiffure', 'label': 'COIFFURE', 'icon': '💇'},
    {'id': 'peinture', 'label': 'PEINTURE', 'icon': '🎨'},
    {'id': 'maconnerie', 'label': 'MAÇONNERIE', 'icon': '🧱'},
  ];

  List<Map<String, dynamic>> get _filteredArtisans {
    return _allArtisans.where((a) {
      final matchesCat =
          _selectedCategory == 'all' || a['cat'] == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          (a['name'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          (a['specialty'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchesCat && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prestataires = _filteredArtisans;

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RÉPERTOIRE',
                    style: GoogleFonts.outfit(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Prestataires Experts',
                    style: GoogleFonts.outfit(
                      color: AppColors.textPrimary,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Bar Glass
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GlassContainer(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                borderRadius: 100,
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  textAlignVertical: TextAlignVertical.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Rechercher un prestataire...',
                    hintStyle: GoogleFonts.inter(
                      color: AppColors.textTertiary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: 26,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),
          ),

          // Category filter chips
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 24),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat['id'] == _selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat['id']!),
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        borderRadius: 100,
                        gradient: isSelected ? AppColors.primaryGradient : null,
                        child: Center(
                          child: Row(
                            children: [
                              Text(cat['icon']!, style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 8),
                              Text(
                                cat['label']!,
                                style: GoogleFonts.inter(
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Results count
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: Text(
                '${prestataires.length} experts à proximité',
                style: GoogleFonts.outfit(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          // Prestataires list
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final a = prestataires[index];
                return ArtisanCard(
                  name: a['name'] as String,
                  specialty: a['specialty'] as String,
                  rating: (a['rating'] as num).toDouble(),
                  missions: a['missions'] as int,
                  isAvailable: a['available'] as bool,
                  onTap: () => _showArtisanDetail(context, a),
                );
              }, childCount: prestataires.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  void _showArtisanDetail(BuildContext context, Map<String, dynamic> prestataire) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ArtisanDetailSheet(prestataire: prestataire),
    );
  }
}

class _ArtisanDetailSheet extends StatelessWidget {
  final Map<String, dynamic> prestataire;
  const _ArtisanDetailSheet({required this.prestataire});

  @override
  Widget build(BuildContext context) {
    final name = prestataire['name'] as String;
    final specialty = prestataire['specialty'] as String;
    final rating = (prestataire['rating'] as num).toDouble();
    final missions = prestataire['missions'] as int;
    final available = prestataire['available'] as bool;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (_, scrollController) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: PremiumBackground(
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      name[0],
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialty.toUpperCase(),
                  style: GoogleFonts.outfit(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 12),
                GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  borderRadius: 12,
                  blur: 10,
                  gradient: LinearGradient(
                    colors: [
                      (available ? AppColors.success : AppColors.error).withValues(alpha: 0.2),
                      (available ? AppColors.success : AppColors.error).withValues(alpha: 0.1),
                    ],
                  ),
                  child: Text(
                    available ? '● DISPONIBLE' : '● OCCUPÉ',
                    style: GoogleFonts.outfit(
                      color: available ? AppColors.success : AppColors.error,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _DetailStat(
                        label: 'NOTE',
                        value: rating.toStringAsFixed(1),
                        icon: Icons.star_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DetailStat(
                        label: 'MISSIONS',
                        value: '$missions',
                        icon: Icons.work_outline_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DetailStat(
                        label: 'SUCCÈS',
                        value: '98%',
                        icon: Icons.verified_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GlassContainer(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  borderRadius: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'À PROPOS',
                        style: GoogleFonts.outfit(
                          color: AppColors.textTertiary,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Prestataire certifié avec une expertise de 10 ans. Spécialisé en installations neuves et rénovations complexes. Intervention ultra-rapide sur Abidjan.',
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: GhostButton(
                        label: 'MESSAGES',
                        icon: Icons.chat_bubble_outline_rounded,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PrimaryButton(
                        label: 'DEMANDER',
                        onPressed: () {},
                        showArrow: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _DetailStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 20),
      borderRadius: 24,
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 22,
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
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
