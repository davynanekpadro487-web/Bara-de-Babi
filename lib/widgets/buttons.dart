import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../core/colors.dart';
import 'glass_container.dart';

/// Gold Button — Style Premium Warm
class GoldButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double height;
  final bool showArrow;

  const GoldButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height = 56,
    this.showArrow = true,
  });

  @override
  State<GoldButton> createState() => _GoldButtonState();
}

class _GoldButtonState extends State<GoldButton>
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
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => widget.onPressed != null ? _controller.forward() : null,
      onTapUp: (_) {
        if (widget.onPressed != null) {
          _controller.reverse();
          widget.onPressed?.call();
        }
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.isFullWidth ? double.infinity : widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: widget.onPressed != null 
                ? AppColors.neonWarmGradient 
                : LinearGradient(colors: [AppColors.backgroundTertiary, AppColors.backgroundTertiary]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: widget.onPressed != null ? [
              BoxShadow(
                color: AppColors.neonBlue.withValues(alpha: 0.25),
                blurRadius: 20,
                spreadRadius: -4,
                offset: const Offset(0, 10),
              ),
            ] : null,
          ),
          child: Stack(
            children: [
              // Shimmer effect
              if (!widget.isLoading && widget.onPressed != null)
                Positioned.fill(
                  child: Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: Colors.white.withValues(alpha: 0.2),
                    period: const Duration(milliseconds: 2000),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              // Content
              Center(
                child: widget.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.icon != null) ...[
                              Icon(
                                widget.icon,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                            ],
                            Text(
                              widget.label.toUpperCase(),
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2.5,
                              ),
                            ),
                            if (widget.showArrow) ...[
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                            ],
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ghost Button — Glassmorphism discret pour thème clair
class GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;

  const GhostButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isFullWidth = false,
    this.icon,
    this.borderColor,
    this.textColor,
  });

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed?.call();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: GlassContainer(
          padding: EdgeInsets.zero,
          borderRadius: 16,
          blur: 15,
          borderWidth: 1.2,
          borderColor: widget.borderColor ?? AppColors.backgroundTertiary,
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.8),
              Colors.white.withValues(alpha: 0.4),
            ],
          ),
          width: widget.isFullWidth ? double.infinity : null,
          height: 52,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: widget.textColor ?? AppColors.textPrimary, size: 18),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.label.toUpperCase(),
                  style: GoogleFonts.outfit(
                    color: widget.textColor ?? AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
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
