import 'package:flutter/material.dart';

/// Design System Barra de Babi — Palette inspirée Lamborghini
/// Dark luxury + Accents Or/Jaune + Touches Ivoiriennes
class AppColors {
  AppColors._();

  // ─── Backgrounds ──────────────────────────────────
  static const Color backgroundPrimary = Color(0xFFFFFFFF); // Blanc pur
  static const Color backgroundSecondary = Color(0xFFF8F9FA); // Gris ultra léger
  static const Color backgroundTertiary = Color(0xFFE9ECEF);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundElevated = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFFFFFFF);

  // ─── Brand Colors ─────────────────────────────────
  // New Neo Colors
  static const Color neonBlue = Color(0xFF00E5FF); 
  static const Color neonBlueDark = Color(0xFF00B3CC); 
  static const Color neonPurple = Color(0xFFB026FF); 
  static const Color neonOrange = Color(0xFFFF6D00); 
  static const Color neonPink = Color(0xFFFF1493); 

  // ─── Accent Ivoirien ──────────────────────────────
  static const Color ivoryGreen = Color(0xFF27AE60);
  static const Color ivoryOrange = Color(0xFFF39C12);
  static const Color ivoryWhite = Color(0xFFFFFFFF);

  // ─── Text Colors ──────────────────────────────────
  static const Color textPrimary = Color(0xFF1E293B); // Bleu-gris très foncé
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnNeon = Color(0xFFFFFFFF); // Texte sur couleurs néon
  static const Color textOnLight = Color(0xFF1E293B);

  // ─── Status Colors ────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // ─── Glass / Overlay ──────────────────────────────
  static const Color glassBorder = Color(0x33000000); 
  static const Color glassBackground = Color(0xE6FFFFFF); 
  static const Color glassHighlight = Color(0x66FFFFFF);
  static const Color overlay = Color(0x33000000); 
  static const Color overlayLight = Color(0x1A000000);

  // ─── Gradients ────────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient neonBlueGradient = LinearGradient(
    colors: [neonPurple, neonBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonWarmGradient = LinearGradient(
    colors: [neonPink, neonOrange],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient premiumGlassGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xF2FFFFFF)], 
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGlassBorderGradient = LinearGradient(
    colors: [
      Color(0x33000000),
      Color(0x1A000000),
      Color(0x0D000000),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
