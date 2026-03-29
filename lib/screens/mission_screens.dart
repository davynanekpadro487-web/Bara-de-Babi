import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/buttons.dart';
import '../widgets/premium_background.dart';

/// Live Tracking Screen — Warm Theme
class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _dotController;
  late Animation<double> _dotAnimation;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _dotAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _dotController, curve: Curves.easeInOut));
    _simulateProgress();
  }

  void _simulateProgress() async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) setState(() => _progress = i / 10);
    }
  }

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUIVI EN DIRECT',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ),
      body: PremiumBackground(
        child: Column(
          children: [
            // Map
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.backgroundSecondary),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // Grid
                      ...List.generate(10, (i) => Positioned(
                        top: i * 50.0, left: 0, right: 0,
                        child: Container(height: 0.5, color: AppColors.backgroundSecondary),
                      )),
                      ...List.generate(10, (i) => Positioned(
                        left: i * 50.0, top: 0, bottom: 0,
                        child: Container(width: 0.5, color: AppColors.backgroundSecondary),
                      )),
                      
                      // Path
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _RoutePainter(progress: _progress),
                        ),
                      ),

                      // User Pin
                      Positioned(
                        bottom: 40,
                        right: 40,
                        child: _MapPin(label: 'VOUS', color: AppColors.primary, icon: Icons.person_pin_circle_rounded),
                      ),

                      // Prestataire Pin
                      AnimatedBuilder(
                        animation: _dotAnimation,
                        builder: (_, __) => Positioned(
                          top: 40 + (300 * _progress),
                          left: 40 + (250 * _progress),
                          child: _MapPin(
                            label: 'PRESTATAIRE', 
                            color: AppColors.success, 
                            icon: Icons.navigation_rounded,
                            scale: 1.0 + (_dotAnimation.value * 0.1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Panel
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5)),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ARRIVÉE PRÉVUE',
                              style: GoogleFonts.outfit(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Dans ${(12 - (_progress * 12)).toInt()} minutes',
                              style: GoogleFonts.outfit(
                                color: AppColors.textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'EN ROUTE',
                          style: GoogleFonts.outfit(
                            color: AppColors.success,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 8,
                      backgroundColor: AppColors.backgroundSecondary,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: GhostButton(
                          label: 'CHAT',
                          icon: Icons.chat_bubble_outline_rounded,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PrimaryButton(
                          label: 'APPELER',
                          icon: Icons.phone_rounded,
                          showArrow: false,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final double scale;

  const _MapPin({required this.label, required this.color, required this.icon, this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color, width: 1.5),
              boxShadow: [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 10)],
            ),
            child: Text(
              label,
              style: GoogleFonts.outfit(color: color, fontSize: 8, fontWeight: FontWeight.w900),
            ),
          ),
          Icon(icon, color: color, size: 32),
        ],
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final double progress;
  _RoutePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.2)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(40, 40)
      ..cubicTo(size.width * 0.4, size.height * 0.1, size.width * 0.6, size.height * 0.9, size.width - 40, size.height - 40);

    canvas.drawPath(path, paint);
    
    // Draw active part
    final activePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // This is a simplification
    canvas.drawPath(path, activePaint); // Just drawing full path for now in simulation
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) => progress != oldDelegate.progress;
}

/// Mission In Progress (Client) — Warm Theme
class ClientMissionScreen extends StatelessWidget {
  const ClientMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MISSION EN COURS',
          style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 2),
        ),
      ),
      body: PremiumBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
                    const SizedBox(width: 8),
                    Text(
                      'INTERVENTION EN COURS',
                      style: GoogleFonts.outfit(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'PLOMBERIE',
                style: GoogleFonts.outfit(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 4),
              ),
              const SizedBox(height: 4),
              Text(
                'Réparation fuite évier',
                style: GoogleFonts.outfit(color: AppColors.textPrimary, fontSize: 32, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 32),
              
              GlassContainer(
                padding: const EdgeInsets.all(24),
                borderRadius: 24,
                borderColor: AppColors.backgroundSecondary,
                gradient: const LinearGradient(colors: [Colors.white, Color(0xFFFCFAF7)]),
                child: Row(
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.primaryGradient),
                      child: Center(child: Text('S', style: GoogleFonts.outfit(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Soro Ibrahim', style: GoogleFonts.outfit(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w900)),
                          Text('PLOMBIER CERTIFIÉ', style: GoogleFonts.outfit(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.phone_in_talk_rounded, color: AppColors.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.backgroundSecondary),
                ),
                child: Column(
                  children: [
                    _InfoRow(icon: Icons.calendar_today_rounded, label: 'Date', value: 'Aujourd\'hui, 14:30'),
                    const Divider(height: 24),
                    _InfoRow(icon: Icons.location_on_rounded, label: 'Lieu', value: 'Cocody, Côte d\'Ivoire'),
                    const Divider(height: 24),
                    _InfoRow(icon: Icons.payments_rounded, label: 'Budget', value: '15 000 FCFA'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              PrimaryButton(
                label: 'VOIR SUR LA CARTE',
                icon: Icons.map_rounded,
                isFullWidth: true,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveTrackingScreen())),
              ),
              const SizedBox(height: 12),
              GhostButton(
                label: 'CONTACTER L\'PRESTATAIRE',
                icon: Icons.chat_bubble_outline_rounded,
                isFullWidth: true,
                onPressed: () {},
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textTertiary, size: 20),
        const SizedBox(width: 16),
        Text(label, style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(value, style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

/// Notification Center — Warm Theme
class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  static const List<Map<String, dynamic>> _notifications = [
    {'title': 'Prestataire en route', 'body': 'Soro Ibrahim arrive dans 5 minutes.', 'time': 'À l\'instant', 'read': false, 'icon': Icons.directions_car_rounded},
    {'title': 'Mission validée', 'body': 'Votre paiement a été reçu avec succès.', 'time': '2h ago', 'read': true, 'icon': Icons.check_circle_rounded},
    {'title': 'Nouveau message', 'body': 'Lassina : "Je suis prêt pour demain."', 'time': 'Hier', 'read': true, 'icon': Icons.chat_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICATIONS', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 2)),
      ),
      body: PremiumBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final n = _notifications[index];
            final isRead = n['read'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isRead ? Colors.white.withValues(alpha: 0.7) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: isRead ? AppColors.backgroundSecondary : AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: Icon(n['icon'] as IconData, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(n['title'] as String, style: GoogleFonts.outfit(color: AppColors.textPrimary, fontSize: 15, fontWeight: isRead ? FontWeight.w700 : FontWeight.w900)),
                        const SizedBox(height: 4),
                        Text(n['body'] as String, style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Text(n['time'] as String, style: GoogleFonts.inter(color: AppColors.textTertiary, fontSize: 11, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  if (!isRead) Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Rating Screen — Warm Theme
class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTER L\'PRESTATAIRE', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 2)),
      ),
      body: PremiumBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                width: 100, height: 100,
                decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.primaryGradient),
                child: Center(child: Text('S', style: GoogleFonts.outfit(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900))),
              ),
              const SizedBox(height: 24),
              Text('Comment s\'est passée l\'intervention ?', textAlign: TextAlign.center, style: GoogleFonts.outfit(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('Notez Soro Ibrahim', style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => IconButton(
                  onPressed: () => setState(() => _rating = index + 1),
                  icon: Icon(index < _rating ? Icons.star_rounded : Icons.star_outline_rounded, color: AppColors.primary, size: 48),
                )),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.backgroundSecondary)),
                child: TextField(
                  controller: _commentController,
                  maxLines: 4,
                  style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 15),
                  decoration: const InputDecoration(hintText: 'Votre avis nous intéresse...', border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
                ),
              ),
              const SizedBox(height: 48),
              PrimaryButton(
                label: 'ENVOYER L\'AVIS',
                isFullWidth: true,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Merci pour votre avis !'), backgroundColor: AppColors.success));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
