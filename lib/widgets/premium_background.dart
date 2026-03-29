import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/colors.dart';

/// Un arrière-plan premium avec des formes floues (Blobs) qui créent de la profondeur.
/// Idéal pour faire ressortir l'effet Glassmorphism.
class PremiumBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? blobColors;

  const PremiumBackground({
    super.key,
    required this.child,
    this.blobColors,
  });

  @override
  Widget build(BuildContext context) {
    final colors = blobColors ?? [
      AppColors.primary.withValues(alpha: 0.5), // Violet vibrant
      AppColors.pastelPink.withValues(alpha: 0.4),
      AppColors.accentLime.withValues(alpha: 0.3),
      AppColors.pastelSkyBlue.withValues(alpha: 0.45),
      AppColors.pastelOrange.withValues(alpha: 0.5), // Orange bien visible
    ];

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.backgroundPrimary,
      child: Stack(
        children: [
          // Blobs (Shapes only)
          Positioned(
            top: -50,
            left: -100,
            child: _BlobBody(color: colors[0], size: 350),
          ),
          Positioned(
            top: 150,
            right: -120,
            child: _BlobBody(color: colors[1], size: 450),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: _BlobBody(color: colors[2], size: 300),
          ),
          Positioned(
            bottom: 200,
            right: 50,
            child: _BlobBody(color: colors[4], size: 280), // Orange blob
          ),
          Positioned(
            top: 420,
            left: 80,
            child: _BlobBody(color: colors[3], size: 220),
          ),
          
          // Unified Big Blur for all blobs below
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(color: Colors.transparent),
            ),
          ),
          
          // The actual content
          child,
        ],
      ),
    );
  }
}

class _BlobBody extends StatelessWidget {
  final Color color;
  final double size;

  const _BlobBody({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
