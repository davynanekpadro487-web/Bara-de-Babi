import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../core/colors.dart';
import '../widgets/buttons.dart';
import 'auth_screen.dart';

/// Onboarding Screen — 3 slides immersifs style Luxury Warm
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    const _OnboardingData(
      icon: Icons.search_rounded,
      title: 'TROUVEZ\nVOTRE ARTISAN',
      subtitle: 'En moins de 2 minutes',
      description:
          'Plombier, électricien, menuisier, couturière... Trouvez un artisan vérifié et proche de chez vous à Abidjan.',
      accentColor: AppColors.neonBlue,
    ),
    const _OnboardingData(
      icon: Icons.verified_user_rounded,
      title: 'ARTISANS\nVÉRIFIÉS',
      subtitle: 'Identité validée (KYC)',
      description:
          'Chaque artisan est vérifié : pièce d\'identité, spécialité confirmée, avis clients authentiques.',
      accentColor: AppColors.ivoryGreen,
    ),
    const _OnboardingData(
      icon: Icons.flash_on_rounded,
      title: 'DEMANDE\nEXPRESS',
      subtitle: 'Brobro, c\'est rapide !',
      description:
          'Un problème urgent ? Notre algorithme trouve l\'artisan disponible le plus proche en quelques secondes.',
      accentColor: AppColors.neonOrange,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const AuthScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.neonWarmGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: _navigateToAuth,
                    child: Text(
                      'PASSER',
                      style: GoogleFonts.outfit(
                        color: AppColors.textTertiary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),

              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return _OnboardingPage(data: _pages[index]);
                  },
                ),
              ),

              // Bottom section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: Column(
                  children: [
                    // Page indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.neonBlue,
                        dotColor: AppColors.backgroundTertiary,
                        dotWidth: 8,
                        dotHeight: 8,
                        expansionFactor: 4,
                        spacing: 8,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // CTA Button
                    GoldButton(
                      label: _currentPage == _pages.length - 1
                          ? 'COMMENCER'
                          : 'SUIVANT',
                      onPressed: _nextPage,
                      isFullWidth: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Color accentColor;

  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.accentColor,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: data.accentColor.withValues(alpha: 0.1),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Icon(data.icon, size: 60, color: data.accentColor),
            ),
          ),
          const SizedBox(height: 56),

          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: AppColors.textPrimary,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),

          // Subtitle
          Text(
            data.subtitle,
            style: GoogleFonts.outfit(
              color: data.accentColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Gold accent line
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [data.accentColor, data.accentColor.withValues(alpha: 0.5)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
