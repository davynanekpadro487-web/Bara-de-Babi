import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
=======
import 'package:flutter/services.dart';
import 'core/theme.dart';
import 'screens/splash_screen.dart';

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
>>>>>>> 75fc9922d75a8d1b774714443b10c26292692c2e

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Artisan App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          primary: const Color(0xFF1E88E5),
          secondary: const Color(0xFFFF6D00),
        ),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
=======
      title: 'Barra de Babi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
>>>>>>> 75fc9922d75a8d1b774714443b10c26292692c2e
    );
  }
}
