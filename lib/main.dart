import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme.dart';
import 'screens/splash_screen.dart';
import 'onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const BaraDeBabiApp());
}

class BaraDeBabiApp extends StatelessWidget {
  const BaraDeBabiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barra de Babi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme, // Ou AppTheme.lightTheme selon le besoin
      
      // J'ai mis l'OnboardingScreen en page d'accueil pour que vous puissiez voir  
      // immédiatement les résultats de notre travail. Si vous voulez repasser par 
      // le SplashScreen de votre nouveau code, remplacez simplement par : const SplashScreen()
      home: const OnboardingScreen(),
    );
  }
}
