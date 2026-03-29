import 'package:flutter/material.dart';

/// Design System Barra de Babi — Soft UI v3
/// Inspired by Dribbble: Smart Home Services App
/// Clean backgrounds + Pastel Accents + Vibrant Purple
class AppColors {
  AppColors._();

  // ─── Backgrounds ──────────────────────────────────
  static const Color backgroundPrimary = Color(0xFFF8F8F6); // Fond très léger beige/off-white
  static const Color backgroundSecondary = Color(0xFFFFFFFF);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFFFFFFF);

  // ─── Brand Colors (Dribbble Smart Home) ───────────
  static const Color primary = Color(0xFF7B61FF); // Violet vibrant
  static const Color primaryDark = Color(0xFF111827); // Charcoal headings
  static const Color accentLime = Color(0xFFD4F731); // Lime pour badges
  static const Color primaryLight = Color(0xFFE8E5FF); // Lavender léger

  // ─── Pastel Accents (Specific to Dribbble Shot) ───
  static const Color pastelMint = Color(0xFF34D399); // More vibrant mint
  static const Color pastelPink = Color(0xFFF472B6); // vibrant pink
  static const Color pastelOrange = Color(0xFFFB923C); // vibrant orange 
  static const Color pastelPeach = Color(0xFFFBBF24); // vibrant amber/peach
  static const Color pastelLavender = Color(0xFFA78BFA); // vibrant lavender
  static const Color pastelSkyBlue = Color(0xFF38BDF8); // vibrant blue

  // ─── Text Colors ──────────────────────────────────
  static const Color textPrimary = Color(0xFF111827); // Charcoal
  static const Color textSecondary = Color(0xFF6B7280); // Grey medium
  static const Color textTertiary = Color(0xFF9CA3AF); // Light grey
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ─── Status Colors ────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFFF9800); // Orange vibrant
  static const Color info = Color(0xFF3B82F6);

  // ─── Shadow & Border ──────────────────────────────
  static const Color shadowColor = Color(0x08000000); // 3-4% noir (très subtil)
  static const Color borderColor = Color(0xFFF1F1F1);

  // ─── Gradients (Subtle transitions) ───────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF927FFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [primaryDark, Color(0xFF1F2937)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient limeGradient = LinearGradient(
    colors: [accentLime, Color(0xFFE2FF4A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFF9E66), Color(0xFFFFC29F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softSurfaceGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF9FAFB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ─── Shadows (iOS 26 Level Depth) ──────────────────
  static List<BoxShadow> get premiumShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 40,
      offset: const Offset(0, 20),
      spreadRadius: -10,
    ),
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.8),
      blurRadius: 1,
      offset: const Offset(-1, -1),
    ),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  // ─── Gradients (Ultra-Translucent iOS Glass) ───────────────
  static const LinearGradient premiumGlassGradient = LinearGradient(
    colors: [
      Color(0x26FFFFFF), // 15% white
      Color(0x00FFFFFF), // 0% white
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGlassBorderGradient = LinearGradient(
    colors: [
      Color(0xB3FFFFFF), // 70% white glow
      Color(0x1AFFFFFF), // 10% white
      Color(0x0A000000), // 4% black (slight depth)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.4, 1.0],
  );
}
