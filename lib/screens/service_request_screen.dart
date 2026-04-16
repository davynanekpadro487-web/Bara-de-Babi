import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../widgets/buttons.dart';
import '../widgets/glass_container.dart';

/// Service Request Screen — Express Request Pipeline with Warm Theme
class ServiceRequestScreen extends StatefulWidget {
  final String? preselectedCategory;
  const ServiceRequestScreen({super.key, this.preselectedCategory});

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen>
    with TickerProviderStateMixin {
  int _step = 0; // 0: categorie, 1: sous-probleme, 2: recherche, 3: match trouvé
  String? _selectedCategory;
  String? _selectedSubProblem;

  late AnimationController _searchController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.preselectedCategory;
    if (_selectedCategory != null) _step = 1;

    _searchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _searchController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Map<String, dynamic>? get _currentCategory {
    if (_selectedCategory == null) return null;
    return AppConstants.serviceCategories.firstWhere(
      (c) => c['id'] == _selectedCategory,
      orElse: () => AppConstants.serviceCategories[0],
    );
  }

  void _selectCategory(String catId) {
    setState(() {
      _selectedCategory = catId;
      _step = 1;
    });
  }

  void _selectSubProblem(String problem) {
    setState(() {
      _selectedSubProblem = problem;
      _step = 2;
    });
    _startSearch();
  }

  void _startSearch() {
    _searchController.repeat(reverse: true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _searchController.stop();
        setState(() => _step = 3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (_step > 0 && _step < 2) {
              setState(() => _step--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'DEMANDE EXPRESS',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.neonWarmGradient),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _buildStep(),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _buildCategoryStep();
      case 1:
        return _buildSubProblemStep();
      case 2:
        return _buildSearchingStep();
      case 3:
        return _buildMatchFoundStep();
      default:
        return const SizedBox();
    }
  }

  // ─── Step 0 : Sélection catégorie ─────────────────
  Widget _buildCategoryStep() {
    return SingleChildScrollView(
      key: const ValueKey('step0'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ÉTAPE 1 SUR 3',
            style: GoogleFonts.outfit(
              color: AppColors.neonBlue,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Quel service\nrecherchez-vous ?',
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: AppConstants.serviceCategories.length,
            itemBuilder: (context, index) {
              final cat = AppConstants.serviceCategories[index];
              return GestureDetector(
                onTap: () => _selectCategory(cat['id'] as String),
                child: Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cat['icon'] as String,
                        style: const TextStyle(fontSize: 32),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (cat['name'] as String).toUpperCase(),
                            style: GoogleFonts.outfit(
                              color: AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            cat['description'] as String,
                            style: GoogleFonts.inter(
                              color: AppColors.textTertiary,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── Step 1 : Sélection sous-problème ─────────────
  Widget _buildSubProblemStep() {
    final cat = _currentCategory;
    if (cat == null) return const SizedBox();
    final problems = List<String>.from(cat['subProblems'] as List);

    return SingleChildScrollView(
      key: const ValueKey('step1'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ÉTAPE 2 SUR 3',
            style: GoogleFonts.outfit(
              color: AppColors.neonBlue,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Décrivez votre\nproblème',
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${cat['icon']} ${cat['name']}',
            style: GoogleFonts.outfit(
              color: AppColors.neonBlue,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          ...problems.map(
            (problem) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: GestureDetector(
                onTap: () => _selectSubProblem(problem),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.backgroundTertiary),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.neonBlue,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          problem,
                          style: GoogleFonts.inter(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textTertiary.withValues(alpha: 0.5),
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Step 2 : Recherche en cours ──────────────────
  Widget _buildSearchingStep() {
    return Center(
      key: const ValueKey('step2'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (_, __) => Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.neonBlue.withValues(alpha: 0.2),
                      AppColors.neonBlue.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.neonBlueGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonBlue.withValues(alpha: 0.3),
                          blurRadius: 35,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            'RECHERCHE EN COURS',
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Nous sélectionnons le meilleur artisan\nprès de vous...',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.backgroundTertiary),
                ),
                child: Text(
                  'Rayon : 3 km',
                  style: GoogleFonts.outfit(
                    color: AppColors.neonBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.backgroundTertiary),
                ),
                child: Text(
                  '4 Disponibles',
                  style: GoogleFonts.outfit(
                    color: AppColors.success,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Step 3 : Match trouvé ────────────────────────
  Widget _buildMatchFoundStep() {
    return SingleChildScrollView(
      key: const ValueKey('step3'),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success.withValues(alpha: 0.1),
              border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
            ),
            child: const Icon(Icons.check_rounded, color: AppColors.success, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'ARTISAN TROUVÉ !',
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 32),

          GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: 24,
            borderColor: AppColors.backgroundTertiary,
            gradient: const LinearGradient(colors: [Colors.white, Color(0xFFFCFAF7)]),
            child: Column(
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
                      'S',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Soro Ibrahim',
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (_currentCategory?['name'] as String? ?? 'ARTISAN').toUpperCase(),
                  style: GoogleFonts.outfit(
                    color: AppColors.neonBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.neonBlue, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '4.8',
                      style: GoogleFonts.outfit(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Icon(Icons.location_on_rounded, color: AppColors.textTertiary.withValues(alpha: 0.6), size: 18),
                    const SizedBox(width: 6),
                    Text(
                      '1.2 km',
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Icon(Icons.access_time_rounded, color: AppColors.textTertiary.withValues(alpha: 0.6), size: 18),
                    const SizedBox(width: 6),
                    Text(
                      '8 min',
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.backgroundTertiary),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RÉSUMÉ DE LA MISSION',
                  style: GoogleFonts.outfit(
                    color: AppColors.textTertiary,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                _DetailRow(
                  label: 'Service',
                  value: _currentCategory?['name'] as String? ?? '—',
                ),
                const Divider(height: 24),
                _DetailRow(
                  label: 'Action',
                  value: _selectedSubProblem ?? '—',
                ),
                const Divider(height: 24),
                _DetailRow(label: 'Prix estimé', value: '10 000 – 20 000 FCFA'),
              ],
            ),
          ),
          const SizedBox(height: 32),

          GoldButton(
            label: 'CONFIRMER L\'INTERVENTION',
            isFullWidth: true,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Artisan prévenu ! Il arrive.',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
          GhostButton(
            label: 'Annuler la demande',
            isFullWidth: true,
            onPressed: () => Navigator.pop(context),
            textColor: AppColors.error,
            borderColor: AppColors.error.withValues(alpha: 0.1),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
