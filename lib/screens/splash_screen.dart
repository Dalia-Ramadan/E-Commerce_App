import 'package:e_commerce_app/screens/welcome_screen.dart';
import 'package:e_commerce_app/widgets/custom_gap.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const splashDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(splashDuration, () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const CustomGap(h: 27),
            Text(
              'SmartShop',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const CustomGap(h: 20),
            const CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 4,
            ),
            const CustomGap(h: 40),
          ],
        ),
      ),
    );
  }
}
