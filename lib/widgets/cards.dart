import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import 'glass_container.dart';

/// Category Card Premium — Warm Theme
class CategoryCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isSelected;

  const CategoryCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.isSelected = false,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GlassContainer(
        onTap: () {
          _controller.forward().then((_) => _controller.reverse());
          widget.onTap?.call();
        },
        width: 165,
        padding: const EdgeInsets.all(22),
        borderRadius: 24,
        blur: 20,
        borderColor: widget.isSelected
            ? AppColors.neonBlue
            : AppColors.backgroundTertiary,
        borderWidth: widget.isSelected ? 2 : 1,
        gradient: LinearGradient(
          colors: widget.isSelected
              ? [AppColors.neonBlue.withValues(alpha: 0.15), AppColors.neonBlue.withValues(alpha: 0.05)]
              : [Colors.white, Colors.white.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shadows: [
          BoxShadow(
            color: widget.isSelected 
                ? AppColors.neonBlue.withValues(alpha: 0.2) 
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? AppColors.neonBlue.withValues(alpha: 0.1)
                    : AppColors.backgroundSecondary,
                shape: BoxShape.circle,
              ),
              child: Text(widget.emoji, style: const TextStyle(fontSize: 26)),
            ),
            const SizedBox(height: 18),
            Text(
              widget.title,
              style: GoogleFonts.outfit(
                color: widget.isSelected
                    ? AppColors.neonBlue
                    : AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: GoogleFonts.inter(
                color: AppColors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Artisan Card Premium — Warm Profile
class ArtisanCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final int missions;
  final bool isAvailable;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ArtisanCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.missions,
    required this.isAvailable,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      borderRadius: 20,
      blur: 15,
      borderColor: AppColors.backgroundTertiary,
      gradient: const LinearGradient(
        colors: [Colors.white, Color(0xFFFCFAF7)],
      ),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: AppColors.neonBlueGradient,
                ),
                child: Center(
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              if (isAvailable)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Info Pro
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  specialty.toUpperCase(),
                  style: GoogleFonts.outfit(
                    color: AppColors.neonBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.neonBlue,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: GoogleFonts.outfit(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.verified_user_rounded,
                      color: AppColors.success,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$missions missions',
                      style: GoogleFonts.inter(
                        color: AppColors.textTertiary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textTertiary,
            size: 14,
          ),
        ],
      ),
    );
  }
}

/// Stat Card — Warm Dashboard
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? accentColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.neonBlue;
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 22,
      blur: 20,
      borderColor: AppColors.backgroundTertiary,
      gradient: const LinearGradient(
        colors: [Colors.white, Color(0xFFFCFAF7)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              color: AppColors.textTertiary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
