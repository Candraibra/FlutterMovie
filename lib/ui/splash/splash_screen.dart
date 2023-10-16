import 'package:beginner_submission/ui/home/home_screen.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // Simulate a delay using Future.delayed
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the main screen after 2 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });

    // Your splash screen UI
    return Scaffold(
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Stream",
                style: textTheme.titleLarge
              ),
              Text(
                "Movie",
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF8F71),
                ),
              ),
            ],
          )

      ),
    );
  }
}