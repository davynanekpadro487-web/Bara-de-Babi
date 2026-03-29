import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/premium_background.dart';
import '../widgets/buttons.dart';
import 'kyc_screens.dart';

/// Auth Screen — Connexion par téléphone OTP style Luxury Warm
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isOtpSent = false;
  bool _isLoading = false;
  String _selectedRole = 'client';

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    if (_phoneController.text.length < 8) {
      _showSnack('Entrez un numéro de téléphone valide');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    // Simulate OTP sending
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isOtpSent = true;
          _isLoading = false;
        });
        _showSnack('Code OTP envoyé ! (Demo: utilisez 1234)');
      }
    });
  }

  void _verifyOtp() {
    if (_otpController.text != '1234') {
      _showSnack('Code OTP incorrect');
      return;
    }
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ProfileCreationScreen(role: _selectedRole),
          ),
        );
      }
    });
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            children: [
              // Content
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 60),

                              // Logo
                              Center(
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.primaryGradient,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 30,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'B',
                                      style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 36,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 48),

                              // Title
                              Text(
                                _isOtpSent ? 'VÉRIFICATION' : 'CONNEXION',
                                style: GoogleFonts.outfit(
                                  color: AppColors.textPrimary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 4,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 40,
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _isOtpSent
                                    ? 'Entrez le code envoyé par SMS'
                                    : 'Entrez votre numéro de téléphone',
                                style: GoogleFonts.inter(
                                  color: AppColors.textSecondary,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Form
                              GlassContainer(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!_isOtpSent) ...[
                                      // Phone input
                                      Text(
                                        'NUMÉRO DE TÉLÉPHONE',
                                        style: GoogleFonts.outfit(
                                          color: AppColors.textTertiary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          // Country code
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 14,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.backgroundSecondary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: AppColors.backgroundSecondary,
                                              ),
                                            ),
                                            child: Text(
                                              '🇨🇮 +225',
                                              style: GoogleFonts.inter(
                                                color: AppColors.textPrimary,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextField(
                                              controller: _phoneController,
                                              keyboardType: TextInputType.phone,
                                              style: GoogleFonts.inter(
                                                color: AppColors.textPrimary,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 2,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: '07 XX XX XX XX',
                                                hintStyle: GoogleFonts.inter(
                                                  color: AppColors.textTertiary,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),

                                      // Role selector
                                      Text(
                                        'JE SUIS',
                                        style: GoogleFonts.outfit(
                                          color: AppColors.textTertiary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          _RoleChip(
                                            label: 'CLIENT',
                                            icon: Icons.person_outline_rounded,
                                            isSelected:
                                                _selectedRole == 'client',
                                            onTap: () => setState(
                                              () => _selectedRole = 'client',
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          _RoleChip(
                                            label: 'PRESTATAIRE',
                                            icon: Icons.handyman_outlined,
                                            isSelected:
                                                _selectedRole == 'artisan',
                                            onTap: () => setState(
                                              () => _selectedRole = 'artisan',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ] else ...[
                                      // OTP input
                                      Text(
                                        'CODE DE VÉRIFICATION',
                                        style: GoogleFonts.outfit(
                                          color: AppColors.textTertiary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      TextField(
                                        controller: _otpController,
                                        keyboardType: TextInputType.number,
                                        maxLength: 4,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.outfit(
                                          color: AppColors.textPrimary,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 16,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          hintText: '• • • •',
                                          hintStyle: GoogleFonts.outfit(
                                            color: AppColors.textTertiary,
                                            fontSize: 32,
                                            letterSpacing: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() => _isOtpSent = false);
                                            _otpController.clear();
                                          },
                                          child: Text(
                                            'Renvoyer le code',
                                            style: GoogleFonts.inter(
                                              color: AppColors.primary,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),

                              // CTA
                              PrimaryButton(
                                label: _isOtpSent
                                    ? 'VÉRIFIER'
                                    : 'ENVOYER LE CODE',
                                onPressed: _isOtpSent ? _verifyOtp : _sendOtp,
                                isLoading: _isLoading,
                                isFullWidth: true,
                              ),

                              const SizedBox(height: 48),

                              // Bottom legal
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Text(
                                    'En continuant, vous acceptez nos Conditions\nd\'utilisation et notre Politique de confidentialité',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      color: AppColors.textTertiary,
                                      fontSize: 11,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.backgroundSecondary,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? AppColors.primary : AppColors.textTertiary,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
