import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/colors.dart';

/// Glass Container Premium — Design UI/UX Pro inspiré Lamborghini
/// Propose un effet de verre dépoli avec reflets de lumière sur les bords.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final Color? borderColor;
  final double borderWidth;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 32,
    this.blur = 40, // Flou intense style iOS 26
    this.borderColor,
    this.borderWidth = 1.0, 
    this.gradient,
    this.borderGradient,
    this.shadows,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Dégradé de bordure par défaut pour l'effet "Reflet de luxe"
    final effectiveBorderGradient =
        borderGradient ?? AppColors.premiumGlassBorderGradient;

    // Dégradé de fond par défaut
    final effectiveGradient = gradient ?? AppColors.premiumGlassGradient;

    Widget content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          // Gloss Glow (Reproduit l'éclat du verre Apple)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.15),
                    Colors.white.withValues(alpha: 0.02),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.3, 1.0],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );

    // Construction du Glassmorphism avec reflets et flou intense
    Widget glass = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadows ?? AppColors.premiumShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: CustomPaint(
            painter: _GlassBorderPainter(
              radius: borderRadius,
              strokeWidth: borderWidth,
              gradient: effectiveBorderGradient,
            ),
            child: content,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: glass,
      );
    }

    return glass;
  }
}

/// Peintre personnalisé pour créer une bordure en dégradé (effet reflet de lumière)
class _GlassBorderPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GlassBorderPainter({
    required this.radius,
    required this.strokeWidth,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_GlassBorderPainter oldDelegate) =>
      oldDelegate.radius != radius ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.gradient != gradient;
}
