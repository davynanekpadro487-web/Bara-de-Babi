import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Couleurs de la charte
  final Color primaryBlue = const Color(0xFF1E88E5);
  final Color primaryOrange = const Color(0xFFFF6D00);
  final Color bgColor = const Color(0xFFF5F7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildFirstScreen(),
              _buildSecondScreen(),
              _buildThirdScreen(),
            ],
          ),
          // Navigation en bas de l'écran en overlay pour TOUTES les pages
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNavigation(),
          ),
        ],
      ),
    );
  }

  // Écran 1: Image de base
  Widget _buildFirstScreen() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/image.png'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  height: 0.9,
                  fontFamily: 'Inter',
                  color: Colors.white,
                  letterSpacing: -1.0,
                ),
                children: [
                  const TextSpan(text: 'Barra'),
                  TextSpan(
                    text: '•\n',
                    style: TextStyle(color: primaryOrange),
                  ),
                  TextSpan(
                    text: 'de ',
                    style: TextStyle(color: primaryOrange, fontSize: 44),
                  ),
                  const TextSpan(text: 'Babi', style: TextStyle(fontSize: 44)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Trouvez un artisan\nou prestataire en un clic.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Écran 2: Plombier (Sans cartes d'icônes)
  Widget _buildSecondScreen() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // En-tête blanc avec le texte "Trouvez le bon artisan..."
          Container(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24, bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            height: 1.1,
                            letterSpacing: -0.5,
                            fontFamily: 'Inter',
                          ),
                          children: [
                            const TextSpan(text: "Trouvez\nle bon "),
                            TextSpan(
                              text: "artisan\n",
                              style: TextStyle(color: primaryOrange),
                            ),
                            const TextSpan(text: "près de chez vous"),
                          ],
                        ),
                      ),
                      // Petite ligne esthétique bleue sous le texte
                      Container(
                        margin: const EdgeInsets.only(top: 8, left: 5),
                        height: 4,
                        width: 120,
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
                // Icône de recherche
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.search, color: primaryBlue, size: 30),
                ),
              ],
            ),
          ),
          
          // Image du plombier occupant le reste
          Expanded(
            child: Image.asset(
              'assets/image/image copy.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ],
      ),
    );
  }

  // Écran 3: Avec `image2.png` (chemin corrigé) et le design parfait
  Widget _buildThirdScreen() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // En-tête blanc avec le texte "Choisissez..."
          Container(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24, bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        height: 1.1,
                        letterSpacing: -0.5,
                        fontFamily: 'Inter',
                      ),
                      children: [
                        const TextSpan(text: "Choisissez\nparmi "),
                        TextSpan(
                          text: "plusieurs\n",
                          style: TextStyle(color: primaryOrange),
                        ),
                        const TextSpan(text: "prestataires"),
                      ],
                    ),
                  ),
                ),
                // Icône de paramètres
                Container(
                  padding: const EdgeInsets.all(0),
                  child: Icon(Icons.tune, color: primaryBlue, size: 36),
                ),
              ],
            ),
          ),
          
          // Image de fond (Coiffeuse image2.png) avec les cartes parfaitement redessinées
          Expanded(
            child: Stack(
              children: [
                // === CORRECTION MAJEURE: Le chemin vers assets/image2.png ===
                Positioned.fill(
                  child: Image.asset(
                    'assets/image2.png',  // Chemin exact fourni !
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                
                // Plus d'ombre noire moche : l'image est claire comme dans la maquette !
                

              ],
            ),
          ),
        ],
      ),
    );
  }



  // Lignes de navigation
  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.0),
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4.0,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: _currentPage == 0 ? primaryOrange : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.0),
                      boxShadow: _currentPage == 0 ? [
                        BoxShadow(color: primaryOrange.withOpacity(0.5), blurRadius: 4, spreadRadius: 1)
                      ] : null,
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _currentPage == 1 ? primaryBlue : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.0),
                      boxShadow: _currentPage == 1 ? [
                        BoxShadow(color: primaryBlue.withOpacity(0.5), blurRadius: 4, spreadRadius: 1)
                      ] : null,
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4.0,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: _currentPage == 2 ? primaryBlue : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.0),
                      boxShadow: _currentPage == 2 ? [
                        BoxShadow(color: primaryBlue.withOpacity(0.5), blurRadius: 4, spreadRadius: 1)
                      ] : null,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
